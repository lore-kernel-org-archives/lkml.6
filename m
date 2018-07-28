Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7375C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7520671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AomvRLyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED7520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbeG1CzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:55:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55584 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbeG1CzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:55:18 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so10048617itl.5;
        Fri, 27 Jul 2018 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2x8nDPZuuKhB6wYlYPeKuzoV5GwJjy/6ecCpJMCiv4=;
        b=AomvRLyQgAFtn2VpbB31hYw1zEV0IB83gKVLlp8WFv8Z0+RIZx0Ct2spt7rVJ3ei2U
         8z1U5OZVTjEnA3feko0IGjvnSDjvEUSDSa8a9fk9HRzbA0mHrrOZnnE02fGOtGE1dWh+
         txXykssy5NfcwaYMiq6D3EptgO1JfyoMq0pGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2x8nDPZuuKhB6wYlYPeKuzoV5GwJjy/6ecCpJMCiv4=;
        b=smI4+4OfGtVg4AFc1iKUMo/vulx7GIskjgq5EhYJlmza5VuQ1eP2mMwON+C/NZH8Gv
         XONBa1HcHgYW+WGAuXCwoT/Fr6bQ0VRF+vmg6Tvi9OC8EtEVTNlKNckEEV3YMXNQERXT
         OI6G55yeAl6LHvQoI2ld+LSi/b5F/EBHuMyLpMcEv3Nf8nRw+gheRmY25oRtbjgO6aAo
         r9oNsL9aGZnxKoEOeWIE2U3duf/64EY7Qy95YT0XMZthacp6j4xJ/svO+DpOIX3UfB27
         Qf/TS1BmXoIUakzv5qx4ocQEe3Au1i91rgTauSuPhovXD+esAJLT4u6W2DgQla+Nvmid
         pUWA==
X-Gm-Message-State: AOUpUlFqJeCWKWv1MC7p/+w+KVsjp9Y2CPOze8ehLj42wF+cpYvHvBUV
        UthiJ38leDXWFpSHP+r2VYaHRfiy8Sy2KGX3kJU=
X-Google-Smtp-Source: AAOMgpcti8ISjVw0U85jNcJHZcY9dgN+9bLo8rQHL1uIaJ5KvWr+fk1uRy92gP9UGTq2iYz9BwTnLfYf2phTKPPmDAI=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr7386492itb.16.1532741448914;
 Fri, 27 Jul 2018 18:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
 <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB4FB32@ORSMSX110.amr.corp.intel.com> <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Jul 2018 18:30:37 -0700
Message-ID: <CA+55aFz9J78kJRrECy=uN8tC9w=MoMQg_Bn6zVMHrTcXDtzQag@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
To:     erik.schmauss@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 5:02 PM Schmauss, Erik <erik.schmauss@intel.com> wrote:
>
> The patch below should be able to fix this.

Yes, the error messages seem gone with this.

I see another ACPI warning, but that one has always been there:

  acpi INT33D5:00: intel-hid: created platform device
  ACPI Warning: \_SB.IETM._ART: Return Package type mismatch at index
0 - found Integer, expected Reference (20180531/nspredef-263)
  ACPI: Invalid package element [0]: got number, expecting [R]
  _ART package 0 is invalid, ignored

and doesn't seem to cause any problems. Just mentioning it in case
somebody goes "yeah.."

             Linus
