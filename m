Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC4C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483C120881
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLqniWXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483C120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbeKFDTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:19:54 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35953 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbeKFDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:19:54 -0500
Received: by mail-wr1-f45.google.com with SMTP id z13-v6so8154715wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Ig45HcKxXPZ8wpLDf4gDrU6dgmN+LF/Vm4M5ekoS8I=;
        b=sLqniWXql67kdIF3VlpJHIn0EEkDSpM5q12Flmh7/oRpchlDf1jp70ZMr4z+XzGSQd
         IqXYEsLauGWz8Q6gMK+S7Kib+j2ybihs+83dAI56LsG0VlSVZ8O39iiJII/b/7SS1Ses
         ZbBkhBayhBJfRseYG3A/+tG2/7gCIhHQ5ZJNe0VcFCvJW5l9jzs7iHhx3OhWWf7v/Odv
         JUdR4sNFaMLqdZ8oGGj07bpyWSlNjXhWDdfNIZZMQXZrGnPy8sAWVRLwuo0txNT/plrC
         lVRUQxU4/4arg46I7x7nkgG3p4NzmsG9q+5RyLYZx+OrjQMNAqvNg3q9T2kXyzLRohMh
         beBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Ig45HcKxXPZ8wpLDf4gDrU6dgmN+LF/Vm4M5ekoS8I=;
        b=C1aasUg+B3YrXgXkeuAFuGSzaxSBRRAASSL009rfojIuJtRycwi7VAE4tPLNt5vCTz
         maLJMB92l0EIR1wRPL7EgTXktKzLUHtfE/QD91AFIHvl0YBzo3mx4UNgXvqLNDSGmheG
         VdP2QxnnpwqsZYJA/+0e6Y6DsQF6OT272YvE4Jf7isULbPS6aAOI5RgDcfGCjEvGeYEk
         prj1oyZL7Ze/2jmJ0pKsvIShgtx7ScHbpSPCNeJOI2lLyzJ43x8aMDOcdcZzAw6NF0+r
         I3iY8Bbj+ptR7ExxZxqoOGV8Ye3AR2WmH7FGEMH5r5d7cWA2AOogl+5lrAv1ZqepS+uy
         PjJg==
X-Gm-Message-State: AGRZ1gLc4gne9qzJNUGnra7kFUZmxQuorGNDJGPC0CtrOrQmu/6BQwL/
        gl3beqLtNTKPswB9bSW9OFM=
X-Google-Smtp-Source: AJdET5fugrVnbtraH70Fk5d/ujfoft45Mfji4QvN2qwWpvRqqTC05/lLN9VnURtoFL8wD2z3FoUKDQ==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr20782595wrq.294.1541440744728;
        Mon, 05 Nov 2018 09:59:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k73-v6sm21193146wmd.33.2018.11.05.09.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 09:59:04 -0800 (PST)
Date:   Mon, 5 Nov 2018 18:59:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Eial Czerwacki <eial@scalemp.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] x86/vsmp_64.c: Remove dependency on pv_irq_ops
Message-ID: <20181105175902.GA32060@gmail.com>
References: <1541439114-28297-1-git-send-email-eial@scalemp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541439114-28297-1-git-send-email-eial@scalemp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eial Czerwacki <eial@scalemp.com> wrote:

> +#if defined(CONFIG_PCI)

This is shorter:

   #ifdef CONFIG_PCI

Thanks,

	Ingo
