Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAB9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDEC21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWAt+M7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDEC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeJFEVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:21:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43239 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeJFEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:21:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so5620326pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB0DTTh21nWSiqBxlzEvgcJtjIyb9adtAJ+PxoNviQs=;
        b=sWAt+M7mow4mEW2Ga2sLaiUes/6LKq2ZV2YkGFmkgfhKPddq0ZsD9fQqa+B75vq0kc
         vzwVyDXnkAkZjYp+oUvrcVLG9N5FRcAsvT22fGGPElocQ5wU5uJ+0FJOvKERgFNvTQBV
         XxD8NCYuVtbxKzD6QZ3MuQEI4OEskJn1cvVEL53IfUVd30q66ddusXJoDcYy0PuX39hU
         IX3cr9kRD2EUKeVxgqenFN3G862haiG40A3Emp2gbBhVeXmoVFV9RP2ocgjqz0DHINlf
         biy+1BXeMxYX/lq1XImMKauiBFIp4ds5P1eS3HyRC/6AEKuQ6PtVzo2xbJyaeXswznBf
         UXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB0DTTh21nWSiqBxlzEvgcJtjIyb9adtAJ+PxoNviQs=;
        b=Ddwe9Bd97q58IvmEIrAltKv4/A8CGgNuV9L3zyMrgD2AIZ3ve4e3Oo2OhoxLeB7n1Y
         mulbdD65V6RZ73AhFPkT8nlac2OLBBdpWLmxJY9dlOXew8dektn0IE6XcpvUoB8HrE+1
         laBDvJ5yjbgGCpHR7aEuCA7zzjzj33+X6cKVnOx8pn1s4yHJwAgmGhDAcSU7Glz+GV1C
         dKKNYNuMLb6OXY9aM1qrxlSdTxowL6LxleMOmkKvQR95qxCUwTp3YSRhzAiHgRGy/ybx
         RFo+gaKpb5bJ1C2vFHQhhIJVkTPCuwc/iAU8Sa0FbmaVcBcM+CtdK9jwkoJ/hoSbhezK
         nVKA==
X-Gm-Message-State: ABuFfoh9/vLMVC0K5a8mohk02qGnAdkYy+bPDvPq1TrBWiPn7PHZk+IL
        O8fiascqWECB1kluKwrVSFHkl1oggKx6RQBzLzEsVg==
X-Google-Smtp-Source: ACcGV63edSUmAY78c0rZZ/VthhNxVM2rMLNc/hF4SP70uQbSurRQu+ixJJsZD9zBQRM0anhvW8m7Kzrys9JFKgvgDzk=
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr13542034pfq.227.1538774458416;
 Fri, 05 Oct 2018 14:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181004010615.19782-1-natechancellor@gmail.com>
In-Reply-To: <20181004010615.19782-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Oct 2018 14:20:47 -0700
Message-ID: <CAKwvOdk1M0t2WeB5AQjwzDy5Pb6HKV=kmh5kWrxNszFzaLjo7Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: iscsi_tcp: Explicitly cast param in iscsi_sw_tcp_host_get_param
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     lduncan@suse.com, cleech@redhat.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 6:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/scsi/iscsi_tcp.c:803:15: warning: implicit conversion from
> enumeration type 'enum iscsi_host_param' to different enumeration type
> 'enum iscsi_param' [-Wenum-conversion]
>                                                  &addr, param, buf);
>                                                         ^~~~~
> 1 warning generated.
>
> iscsi_conn_get_addr_param handles ISCSI_HOST_PARAM_IPADDRESS just fine
> so add an explicit cast to iscsi_param to make it clear to Clang that
> this is expected behavior.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/153
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/iscsi_tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index b025a0b74341..23354f206533 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -800,7 +800,8 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
>                         return rc;
>
>                 return iscsi_conn_get_addr_param((struct sockaddr_storage *)
> -                                                &addr, param, buf);
> +                                                &addr,
> +                                                (enum iscsi_param)param, buf);

Alternatively, you could also just pass ISCSI_HOST_PARAM_IPADDRESS in
place of the cast (since in this case param ==
ISCSI_HOST_PARAM_IPADDRESS), but I don't feel strongly about this
(maybe the maintainers do).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>         default:
>                 return iscsi_host_get_param(shost, param, buf);
>         }
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
