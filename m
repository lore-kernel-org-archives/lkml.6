Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9930CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiJdWlHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F1D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIFWd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:33:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFWdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:33:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so5600375pge.12;
        Thu, 06 Sep 2018 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7wP83UWWdy3oHS2ydsR4I/R3KsYvz9J3rPpQO0wa5MM=;
        b=tiJdWlHd4MGiiKqXf2m5GrTZqzotetGFif4zWTILTtLl+me4yQuz4TWOEr1aqPfjwO
         U18HQ2G89b8Sg3z8b5IFevLFjKkbvtnQfP7rRej5sJyuUnhlRz1Gqj2Fz9Czv4XtArsI
         Pj6TCETm98z9euvIHozex10oHz1L90EBtIQC6vcR34xOhTswaL+XDzLf96YaWniinQ0O
         FSJxaVuWQhq/t1qZYD/6fL7DLsBFNabjDLfEEApTWRyd9/E3m6TLwUWV0Zz7tOnEbtse
         pi57fty2qI1TVsxHMccTqXzrO/GftcKXskqRG1pE4ybX716UCvx00Cn5irz/3Ht46ziq
         wW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wP83UWWdy3oHS2ydsR4I/R3KsYvz9J3rPpQO0wa5MM=;
        b=XM/ObGBbyt09Yw8mGCjmU6XzqhFZBTcmEg0GIGbIgnsRJ8mTwUgRWdT4+NEt2H+zov
         z+lkFZo8t5Kfhr7n7FG+FcBn144yP5KyDeaX0sY4kVPgPFKv6PQSDTDbkGAJ/nJPoN0A
         lKNJLKL79RDaxL6Z3PK6xGxsZl5qiue8JwafpEilxtvZgzztaUprWMeMygFauWiqY7uJ
         HGSg6jo9AOGkvtYLCLGsgGc7kIjk/oWmCTcXSbn3s6ib8ECydSZgrtED7ASogxhwI0h1
         2OjOLnWslZ7cUauIzUbWZeLA5BjaCMO2aXCL2DJnQNsmoqyRv63glGePAoX+IBvhQNM6
         DMCQ==
X-Gm-Message-State: APzg51C+X/XsvTKJLV3z6GHiGtYA35JhgLgeJawenQ4BASRsl/Jzbnah
        dVeEpKJkfeC0YP3iGQF52Ok=
X-Google-Smtp-Source: ANB0VdaHhqI306R1+Qhv5D2j8QhTvj5ZgIVoPKaqSKVj5E+C1MRr4e++Qzn2zCOlAubIBK8J0EQFDw==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr4140745pfb.13.1536256640120;
        Thu, 06 Sep 2018 10:57:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:7a4e])
        by smtp.gmail.com with ESMTPSA id e64-v6sm8626246pfk.87.2018.09.06.10.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 10:57:19 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:57:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mauricio Vasquez B <mauricio.vasquez@polito.it>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: add missing executables to .gitignore
Message-ID: <20180906175716.5vaxpmclyvottvys@ast-mbp.dhcp.thefacebook.com>
References: <1535990727-2778-1-git-send-email-mauricio.vasquez@polito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535990727-2778-1-git-send-email-mauricio.vasquez@polito.it>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:05:27PM +0200, Mauricio Vasquez B wrote:
> Signed-off-by: Mauricio Vasquez B <mauricio.vasquez@polito.it>
> ---
>  tools/testing/selftests/bpf/.gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 49938d72cf63..4d789c1e5167 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -19,3 +19,7 @@ test_btf
>  test_sockmap
>  test_lirc_mode2_user
>  get_cgroup_id_user
> +test_skb_cgroup_id_user
> +test_socket_cookie
> +test_cgroup_storage
> +test_select_reuseport

Applied, Thanks

