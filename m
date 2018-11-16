Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBD82086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2nvsr64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBD82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeKQHWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:22:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:22:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so4338046wrr.12;
        Fri, 16 Nov 2018 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BC1w6P0CB9RLFC5YOSG2/HDVjpsersFEwFrSNpOU4Pw=;
        b=R2nvsr64iLS7DB0wqQJ3w7moc54rRBtbZdwf0gEAUfw4m1+OFWDQk/Qi3zy8PALtFH
         R9AaLp5Aq0kmb0pLmQ9QEN/th1K6mkEVvHhmgYI8zQitqBfS9yizENf0WhLY7CZG3214
         PjT6ODDR+xXqbqhO3+uGmMvK809nmNPg8E2oz0yCsrNu7dnhC1UopZNhQqn3/ltsskT8
         1zbhFaE3DdQnOBf1AgeoIQLSdnWVTRz/74kLAh9Y4z9rQIMmSf99vUFX799WR4ahE6B6
         7EMlsX+rwlNfU1K85tb+8lBvVfFR72kzVFIzjIvqQVcBmFUvh0IjygBpT3T1Tjv5bB8m
         iynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BC1w6P0CB9RLFC5YOSG2/HDVjpsersFEwFrSNpOU4Pw=;
        b=uQ1rBPQacIZ7Ek1BGsTNblVaU0b1uvg39WAkiPYQ04X3YJ/jMTxibaq6GdPGDFwxRm
         fNvEoX4jRNzv3l+CcXMUAb5q+e1F1dD24GsndVBZG5PK4NOKRaBbQViucq/620/bDZQm
         7UOF34jSoHj+4QkeCDQRsEYu0jqJvjyasI/hg0yQ9tQE44UYtRXtWfj5hfU7uR/ZV+iI
         jgVr1H/1qwn+7HdUe5dDOX1Aff9HcXFTnc9U5qn3EqyHYcMFkYa8/1dotOaV3bXahxMD
         Z0tmGYf2NGnYQ73Me45sGY+MNZ7RqzAz+WHb+MN09fuirz2o12ISXEl/phLk1m/mZ2Xe
         xEQA==
X-Gm-Message-State: AA+aEWau6zJrX7dWl8E/Uxhsb46b0jrJ0rvGb1mPVFShhB60ErHQ4fcg
        Rqmue4z/teh7UVGcpJY4G4g=
X-Google-Smtp-Source: AFSGD/XFknH09SdGDeh1Quy19CqKS9qO8uEJ2g5zg8K2vyWXLNIcalYv/q0whyvCFGbDYYqvCau6AA==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr4576465wrw.323.1542402517186;
        Fri, 16 Nov 2018 13:08:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a82b:74be:ff38:41b5? ([2001:b07:6468:f312:a82b:74be:ff38:41b5])
        by smtp.googlemail.com with ESMTPSA id j129-v6sm26497772wmb.47.2018.11.16.13.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 13:08:36 -0800 (PST)
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
To:     Bart Van Assche <bvanassche@acm.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org> <20181111134241.GA2447@thunk.org>
 <20181112082013.GA9307@infradead.org>
 <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
 <20181116093225.GA17033@infradead.org>
 <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
 <20181116174352.GH20617@thunk.org> <1542392239.100259.52.camel@acm.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <c94ce566-c788-7dc2-4b76-a57fd78aaec8@redhat.com>
Date:   Fri, 16 Nov 2018 22:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542392239.100259.52.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 19:17, Bart Van Assche wrote:
> On Fri, 2018-11-16 at 12:43 -0500, Theodore Y. Ts'o wrote:
>> I'd argue that a purpose-built eBPF access control facility is
>> superior to the security_file_ioctl() LSM hook because it can make
>> available to the authorization function access to the cached results
>> of the SCSI INQUIRY command, and it avoids needing to duplicate
>> knowledge of how to parse the parameters of the SG_IO ioctl in the LSM
>> module as well as in the SCSI stack.
> 
> If an eBPF program would decide which SG_IO commands will be executed
> and which ones not, does that mean that a SCSI parser would have to be
> implemented in eBPF? If so, does that mean that both the eBPF and the
> LSM approach share the disadvantage of requiring to do SCSI CDB parsing
> outside the SCSI core?

The LSM approach cannot do SCSI CDB parsing, unless you add a special
SCSI-specific hook called after parsing the SG_IO argument, due to race
conditions.  I'd rather not do that, however it would have that
disadvantage indeed.

The eBPF approach pushes the policy and the parsing entirely to
userspace, so I'm not sure you can say it's a disadvantage.  It's just a
different design.  If you use SG_IO you're already in for writing
userspace code that handles CDBs, sense data etc.

Paolo
