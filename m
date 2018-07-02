Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5E25524
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irwmh9gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B5E25524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeGBOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:55:11 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42452 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeGBOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:55:04 -0400
Received: by mail-yw0-f193.google.com with SMTP id y203-v6so5014996ywd.9;
        Mon, 02 Jul 2018 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3Iz0TB6rFAalUxLO/i9SPde55lqIbno9b/C05L6dcI=;
        b=irwmh9gBobjVx4hjhwClOJQV9jqc0scj6HlX7nC93g5mEHA80s8v6DBf6cy1rEOjQf
         JhWb/s1lO+CNJkZKhMFSQbZa7xltrWMykGfBGQxidXbI2DWb6chqXH4H+7QZJKN+qoLO
         YkMIaZ4lEilRSA1/HLKz+15+D7XsY0AuxBq2DurKBIcB1ausp9jyrhOuSYRyyqjrorYb
         4HWIVisd3jBiL59wHAWQRh/VYpL1LuhPT4+2ryMcKHGsqFSceh6m62+vyaOxyQ/9FZ4h
         eQhZvvSP5DmI5J9eOqhkDzcrxXSQURyovLWGTv/sqzho3ifGhNnYap9SOYacbEkliYAR
         8lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3Iz0TB6rFAalUxLO/i9SPde55lqIbno9b/C05L6dcI=;
        b=XYifoJO0fHwo+YdUzzltogHLEeMtkWg3ngzTGD8RmR/L9Q7Se7PYsuneMTBUo/DEma
         LQ5Yn0bUCbdOALvCvPRLhuIGj4C6HBskK9GPwQkPX4G4k3NOmNZ5nntReP7zDB0Iba8F
         2GsFm7h/FFGrYqrDeaHgKIudLdS3ar/6LqgbvUKkXntGRvhU+eZuUjkegX/YFWrfT1ey
         XhOCUBbTYge6mnmxN7U2Ly20Rsukx6jWNCcX3v8hqOkOZ7fOfKCyIV0S0goWtJrq4Cy0
         F3kmxzwt6/YE98+of3IRHgtC8Ifcg2ujYo+ONSYXgexksytmI+jLaVEuSPaLe5CwSPSW
         7FQQ==
X-Gm-Message-State: APt69E0aIL1kRkhpSaGbhpGkyinL+7nfRR4A1oqU5rh/ZmvMJ+S+8aoQ
        RUkym2eSuy3kDLBZY3FVMS8=
X-Google-Smtp-Source: AAOMgpfpsjTVXZS+ecSyKtj0326gwXkiapPJrxdwg2+tQwUzFL9kvPumCNb0pz1bhr41LO4DPjsQyA==
X-Received: by 2002:a81:8501:: with SMTP id v1-v6mr12167723ywf.25.1530543302686;
        Mon, 02 Jul 2018 07:55:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id h9-v6sm3048946ywa.63.2018.07.02.07.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:55:01 -0700 (PDT)
Date:   Mon, 2 Jul 2018 07:55:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ahci: Disable LPM on Lenovo 50 series laptops with a too
 old BIOS
Message-ID: <20180702145500.GC533219@devbig577.frc2.facebook.com>
References: <20180701101546.10319-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701101546.10319-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 12:15:46PM +0200, Hans de Goede wrote:
> There have been several reports of LPM related hard freezes about once
> a day on multiple Lenovo 50 series models. Strange enough these reports
> where not disk model specific as LPM issues usually are and some users
> with the exact same disk + laptop where seeing them while other users
> where not seeing these issues.
> 
> It turns out that enabling LPM triggers a firmware bug somewhere, which
> has been fixed in later BIOS versions.
> 
> This commit adds a new ahci_broken_lpm() function and a new ATA_FLAG_NO_LPM
> for dealing with this.
> 
> The ahci_broken_lpm() function contains DMI match info for the 4 models
> which are known to be affected by this and the DMI BIOS date field for
> known good BIOS versions. If the BIOS date is older then the one in the
> table LPM will be disabled and a warning will be printed.
> 
> Note the BIOS dates are for known good versions, some older versions may
> work too, but we don't know for sure, the table is using dates from BIOS
> versions for which users have confirmed that upgrading to that version
> makes the problem go away.
> 
> Unfortunately I've been unable to get hold of the reporter who reported
> that BIOS version 2.35 fixed the problems on the W541 for him. I've been
> able to verify the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION from an older
> dmidecode, but I don't know the exact BIOS date as reported in the DMI.
> Lenovo keeps a changelog with dates in their release notes, but the
> dates there are the release dates not the build dates which are in DMI.
> So I've chosen to set the date to which we compare to one day past the
> release date of the 2.34 BIOS. I plan to fix this with a follow up
> commit once I've the necessary info.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
