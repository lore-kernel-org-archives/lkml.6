Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B45C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B69520818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGg9YksB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B69520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbeKPRLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:11:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52781 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:11:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so20935516wmb.2;
        Thu, 15 Nov 2018 23:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUhrgDiAQbXZQT2sHXYsl5btZrSVIcsylgZkHX/u+L0=;
        b=QGg9YksBCm3hUgiy5g1hM4cGVeMXarZgrm76J9k+d70loEgyMRL5IGsLq6c9McKNr8
         c8qU1cGGoB3BGp1mEQj2fZuB5WSP4hg1gJtUxcgkL+M4cGNRKLXzUyX9xzSgkn3+ZljU
         gj/SNO0I+s36DtWZqzlKph8dFln9/UfKzUl3PTc/s3RCaK6an1avXAGsGQizLMIEs27U
         ZuqeEoXY/UCAMsAfg3aTfu6CuqnUdnS3nhOp97fcYrDqH/gJXDC3gqo1z8MlZIY623/E
         kZAYTwbTYsK9Xs0lKFPGpwF8LLubw64tl13K61YV4unouh8Q/xUmC3Ktu2wMrDuCzX3+
         S/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uUhrgDiAQbXZQT2sHXYsl5btZrSVIcsylgZkHX/u+L0=;
        b=UFKwXbmujxEu69drv2EgJLnlndKzOgHQHlr2vgoO6QT0goqOF4WTbyBPccBPIq13/R
         H7BfkxL7qAw7bQ1rg7ReqNjkFTbLy79vsdvdYeLqjXTjIvc4VdU7DjoPRoRJZOJd4tEV
         u3nBkGCU4bFJfUUTAQ0VWM7wZV8Lvoc67dfZDCthAuIS79vWD+LBWj9FvD2XDbsCyDCg
         jI3k37Qgi0v/WyjmjDWPHIZkEzyMLX65dxNEHDXdwWirnEPRrgjKVl+J3Sj6RlrHhvpZ
         BZ8BQtg5hkPeZWoBVQP5J10wS7O71MkqGnpAI6zoYaBr0rKqmey+zDg0Jaw/T2iZmv6I
         2wOg==
X-Gm-Message-State: AA+aEWY12rMn6xMISruDLbc5NK5VpUq1tPrvsaeOC6cYsGYh6DPlBB2f
        ZsjW2s1pyHzQm3tH/SG7ax8=
X-Google-Smtp-Source: AJdET5dJRIQ2wax1RlpOyCY4cqlS73eq6H+TTaakHIrnwddqR4y9azz5EeFkCBPEZs78lBIbtoo2IQ==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr1370244wmg.23.1542351636471;
        Thu, 15 Nov 2018 23:00:36 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm52023713wmf.22.2018.11.15.23.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:00:35 -0800 (PST)
Subject: Re: [PATCH 3/3] block: add back command filter modification via sysfs
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <1541867733-7836-4-git-send-email-pbonzini@redhat.com>
 <1542347164.100259.32.camel@acm.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <44a2a5d0-1802-e6b0-b6e2-5930eed37e21@redhat.com>
Date:   Fri, 16 Nov 2018 08:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542347164.100259.32.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 06:46, Bart Van Assche wrote:
> I do not know any application for which it would be useful to allow some but
> not all of these commands. With the proposed interface however users will
> have to examine all SCSI opcodes and for each opcode they will have to decide
> whether or not it should be allowed. Additionally, for opcodes like 7fh that
> represent multiple commands, users will have to decide whether they want to
> allow all these commands or none. That's why I think that filtering SCSI
> commands based on their CDB is an unfortunate choice. Would it be sufficient
> for the use cases you are looking at to group SCSI commands as follows and to
> enable/disable these commands per group:
> * SCSI command that read information from the medium (e.g. READ) or from the
>   controller (e.g. READ CAPACITY).
> * SCSI commands that modify information on the medium (e.g. WRITE).
> * SCSI commands that modify controller settings (e.g. MODE SELECT or SET
>   TARGET PORT GROUPS).

And also:

* all SCSI commands (e.g. write microcode, vendor specific commands).

It would.  However, it would be impossible to do this without making the
filter depend on the SCSI device type.  This has been rejected in 2012.

Paolo
