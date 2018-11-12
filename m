Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC69C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8BB223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK4i63bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8BB223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeKLUMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:12:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:12:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so7865479wmb.2;
        Mon, 12 Nov 2018 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIW2d66vHTApqG4+T89kd3a3Y0+9UA9ghJAF2Ej0Thk=;
        b=BK4i63bUfRSgN+h2pkCIRKekrCxh+BW3d26O/cx+fL1d9byICV17rogfRrT4ZXvXIV
         UHQpsh5wBgNY6NxC3tHMKwZjkwmyw2s2YZFSTe1TvBfiTMs0RKd4DumOsznUspyGgmzp
         pA0AzBvHZxSGQt4QaHrvvzhbnQT9p2GLcHA4qtCDcjEHlHFmkqMdR9fmVfBI+36jAPQc
         /fPMyMF+VV1oSSsaVt1+eczYqz+o0+D9N58XMpNVfwU96OQTpM+49QgpoEpdckz1cdiU
         dajaSD+Wy8gJXBIJlgFfHB9f6KdSzGLUgMYXSwo0e6KcHBTeYlEjAWrBBnN+LpHiiXkA
         9mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PIW2d66vHTApqG4+T89kd3a3Y0+9UA9ghJAF2Ej0Thk=;
        b=VT5rA+eg13Lc+5LtfumiZvEbFbe46PyxXPiwa3Rmj0LiDlNqj9yw/jbsil5jecXA3R
         kNRBjnBskQKmVNXiw44HW4OIdnzOr46ocy8SphjRvWmlHzPI3oAfz7vVyV+2sghvl2/M
         KZoSKChIG/JXLjaFj1mWK5+6xam051173jwImjsLWVZ6kZx/ExQa+KpZbbzwb/9QJwtv
         K87IA5ODB11I3r3MJh6ZHW7JJxrpM2vacy9XE9stbphWnXvV5DlVkzfeneVuH2cq0Sd4
         8eMjlyEgOpchhLqNIKkk7YTSZuFYL3ZXuTsXlfZHGCtLM5FiPsdGst2ssLF4B/aw1Tzl
         7OJg==
X-Gm-Message-State: AGRZ1gIIOn/jbWix5CfAoMH9va8DAELtEX4lO+FoMVMAf6jLARMkcJpP
        s50WKm+8fXSRKFRMuBjm+lU=
X-Google-Smtp-Source: AJdET5fbR7BAyD2OUMb2o5ms+U8dCYlVY9c3jyCzGvOWGAg0Pbi57JbZSVSa1tmVG56u3iDGsc9XMw==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr836794wmf.14.1542017981853;
        Mon, 12 Nov 2018 02:19:41 -0800 (PST)
Received: from [192.168.10.165] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id y138sm1141586wmc.16.2018.11.12.02.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:19:41 -0800 (PST)
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
To:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org> <20181111134241.GA2447@thunk.org>
 <20181112082013.GA9307@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
Date:   Mon, 12 Nov 2018 11:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181112082013.GA9307@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 09:20, Christoph Hellwig wrote:
> On Sun, Nov 11, 2018 at 08:42:42AM -0500, Theodore Y. Ts'o wrote:
>> It really depends on the security model being used on a particular
>> system.  I can easily imagine scenarios where userspace is allowed
>> full access to the device with respect to read/write/open, but the
>> security model doesn't want to allow access to various SCSI commands
>> such as firmware upload commands, TCG commads, the
>> soon-to-be-standardized Zone Activation Commands (which allow dynamic
>> conversion of HDD recording modes between CMR and SMR), etc.
> 
> Well, that's what we have the security_file_ioctl() LSM hook for so that
> your security model can arbitrate access to ioctls.

Doesn't that have TOC-TOU races by design?

Also, what about SG_IO giving write access to files that are only opened
read-only (and only have read permissions)?

Paolo
