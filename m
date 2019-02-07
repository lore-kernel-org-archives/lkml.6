Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6043DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2400F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE/sQ61e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:30:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:30:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so317785pfi.5;
        Thu, 07 Feb 2019 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjhoqzPlyk5EPIUhC1bEZzo7yr2zRqeq3BZG9xotq2A=;
        b=oE/sQ61edFbIM86XAQfyPsLb/re6N40kunwLtWCI4+m42qW00CWWbwWwe5E5BCrdS3
         Oipoqv2Z+A1jU3k0KYjrO75Z5KBpkM1rpZpTuJEsnEi6urbg8gWnR2gM+eHElQBkXb2I
         U0XICDL3u2mLtlJ98v2UycHsb0oPCReVtzBbMEF60DAf64lXvUpBZuLiMXVTdOBCGyE2
         ropJ6EErCfgxwYdZeBDtrRN6XYOdOEpspk+i9ZhKKeLBI8885DXjgRCfFX6GxZNgwBIR
         IsS8QJIGvC+IhBd+gYhzscRv/HLyo1Q6FyJlmaXIVsr2+7xjut4jghnJzTGMiXyZK9Bh
         j+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjhoqzPlyk5EPIUhC1bEZzo7yr2zRqeq3BZG9xotq2A=;
        b=blaig1LDyYcQd1XQEz6x7+AKZUFx8ZNqTRq/tEme6XnVfixyEVVdBHhiIsF+uta+bZ
         2uSp1CiwgaQvb0inafP+3yNu4sWno5+Ildtj+2w6CRNuqC/9rlE4SZHQ1dYPN7Y7se/O
         KmDAUMMhSIb0YP+N6lpPhf6BgFcqcs011tqGnAWJzkD60X7MokPUKbbq5y9GOm+mCM56
         QYe4cDC5AVlNSlIiiThRuAVnlEFuT0q2QzdEBMmgoKebidSrNT0osKGb1Nu0AfqOLiDj
         ysMcHbdMfmLTtPL429DY5JxqJC5/wAb+jxVn92RXpFcJ3cJsh/+lFn9NG55sQN2+b0/b
         O1kA==
X-Gm-Message-State: AHQUAuYDLPzpQRRVJO3F2Com+4qEcSOgaPwJzRJBXBQVCIttTsG1xkQF
        U2t6cbVaEk99Tm8XpPT96Bwk2X+N
X-Google-Smtp-Source: AHgI3IYhXfyRuQZ2zafmt76iKoS24Uow3RHr3oJgV1PAaj2ROBHvjNG/rGQuYgLvfZdEvqIy92DNaA==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr17509820pfo.20.1549564205055;
        Thu, 07 Feb 2019 10:30:05 -0800 (PST)
Received: from [10.69.52.190] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g20sm10015073pfg.85.2019.02.07.10.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:30:04 -0800 (PST)
Subject: Re: linux-next: manual merge of the scsi-mkp tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>
References: <20190207154446.3f48c496@canb.auug.org.au>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <eea2211e-6342-1949-5a3e-2c08b87db0d9@gmail.com>
Date:   Thu, 7 Feb 2019 10:30:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207154446.3f48c496@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2019 8:44 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
> 
>    drivers/scsi/lpfc/lpfc_nvme.c
> 
> between commit:
> 
>    7961cba6f7d8 ("scsi: lpfc: nvme: avoid hang / use-after-free when destroying localport")
> 
> from Linus' tree and commit:
> 
>    4c47efc140fa ("scsi: lpfc: Move SCSI and NVME Stats to hardware queue structures")
> 
> from the scsi-mkp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 


Thank You. The fixup patch looks correct.

Martin, let me know if there's anything else you'd like me to do.

-- james

Signed-off-by:  James Smart <james.smart@broadcom.com>
