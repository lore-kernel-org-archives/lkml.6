Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA127ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C482086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mind-be.20150623.gappssmtp.com header.i=@mind-be.20150623.gappssmtp.com header.b="qSjFaM4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mind.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeKESwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:52:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35623 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbeKESwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:52:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id d6-v6so6892196edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind-be.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=THXwSUzI54Njzu6rFzyGeb5GRHs6YJMZyaZEq9KDJw0=;
        b=qSjFaM4k/vjkw4H2ppy0UIex8BAlTcVg1L3rO2cqjWUiSvbdvDpBcrapZvCpp081Nw
         LN3s4jSUaD6OG++4n1lmHa4zbZyFjdQODlG/5ox+oQG0/5R93gDrVEYheR3JFvEOY/Xv
         +zQ8an0A39Rs1WcYq8ZYev/B8roqXOuCAV4/Pljs0EgP+3XbFOK0bUa5E5lSxMs6iZuF
         uAE4NJU5UKXZUj7gCnf61KFaVGdmjV+W38u7zgDuXLgfRRRylEXAAYLE601UefXJhQmv
         dazvLkY24N9tBeUtqKuwPESSRWZ2FFqkdczv1RZ8VwzePjzEHJXveLlW2xU6Ex7+K+ea
         GwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=THXwSUzI54Njzu6rFzyGeb5GRHs6YJMZyaZEq9KDJw0=;
        b=YF/1uk/br5oI/B8UREJq7QuJ9qIzkrzcL+gP8766It2s/DyjOemKvoLO1KFH+sIlNi
         /otaEsQB3PXPmp9KwOD2n/AmBEyOcUzezjtvrf28/6Rvxl6efdKutQG8YsBQi932TV5N
         OAIKrNP4iazokuWqeEoqUOb9lQomWWI18P8KLfk27A/k1aqm8UUYucgBN1xsCTFDt1gy
         xUPqmYEaQk2QX4h9meu0MPI+FauAwROK/QYMKo++RMmmr3ofW6t8LnZjnMgvpIgqtnJH
         cskeq8YtY535slo+3XNOQiaGraGHa1wq0m5vnHNhGKMVn9AJ6k8pwG/0lMdbXKZr0ZAB
         Sn9g==
X-Gm-Message-State: AGRZ1gLZjJ46fLIZQzin+a37ifUWpZ3ul5N0QYCQTZMqeiC7pMhId0B1
        b+i0dz5Wc32Vl6TXSRPdJvnV6lMTJ0+9vQ==
X-Google-Smtp-Source: AJdET5dMWwA7ZtOGeDPkl6PCn2/StwXSKHpUdD7r1VYFyeOeFFZFdbWWNuq1vvfhV7wYGgpDpqIQPA==
X-Received: by 2002:a17:906:92d1:: with SMTP id d17-v6mr7631049ejx.96.1541410389418;
        Mon, 05 Nov 2018 01:33:09 -0800 (PST)
Received: from [192.168.44.159] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id c2sm11329495edv.14.2018.11.05.01.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 01:33:08 -0800 (PST)
Subject: Re: [PATCH v2] kconfig: merge_config: avoid false positive matches
 from comment lines
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Nasser <afshin.nasser@gmail.com>, linux-kernel@vger.kernel.org
References: <1541405976-13747-1-git-send-email-yamada.masahiro@socionext.com>
From:   Arnout Vandecappelle <arnout@mind.be>
Organization: Essensium/Mind
Message-ID: <68478c42-2703-0d24-bf6b-8d75d024722a@mind.be>
Date:   Mon, 5 Nov 2018 10:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1541405976-13747-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/18 09:19, Masahiro Yamada wrote:
> The current SED_CONFIG_EXP could match to comment lines in config
> fragment files, especially when CONFIG_PREFIX_ is empty. For example,
> Buildroot uses empty prefixing; starting symbols with BR2_ is just
> convention.
> 
> Make the sed expression more robust against false positives from
> comment lines. The new sed expression matches to only valid patterns.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Reviewed-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

 Regards,
 Arnout

> ---
> 
> Changes in v2:
>   - Another (more precise) implementation approach
>     based on the option from Arnout Vandecappelle.
>     This is still easier to read, but adds a bit duplication.
> 
>  scripts/kconfig/merge_config.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index da66e77..0ef9064 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -102,7 +102,8 @@ if [ ! -r "$INITFILE" ]; then
>  fi
>  
>  MERGE_LIST=$*
> -SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
> +SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
> +SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
>  
>  TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
>  
> @@ -116,7 +117,7 @@ for MERGE_FILE in $MERGE_LIST ; do
>  		echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
>  		exit 1
>  	fi
> -	CFG_LIST=$(sed -n "$SED_CONFIG_EXP" $MERGE_FILE)
> +	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
>  
>  	for CFG in $CFG_LIST ; do
>  		grep -q -w $CFG $TMP_FILE || continue
> @@ -159,7 +160,7 @@ make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET
>  
>  
>  # Check all specified config values took (might have missed-dependency issues)
> -for CFG in $(sed -n "$SED_CONFIG_EXP" $TMP_FILE); do
> +for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
>  
>  	REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
>  	ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG")
> 
