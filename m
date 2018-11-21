Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29899C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AF214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Jz0laTOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2AF214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeKVDeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:34:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42845 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeKVDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:34:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so6328728pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8/tsUmK+L+AVrTCjUUiN4ztrNLnvqex6j+W5ttx8BT4=;
        b=Jz0laTOx+Ssh7lZuUo7Ll++zQ94vMQ3nqBTsfFkEROEUsITsEEfu0f5v/m23dMyMte
         2kEEPFtTZB0gl2KENitMzsJB37eaI7TnjC4lxQI1prP+h+31DqDNj6u5yyA02ogiWlCl
         76ZvOQFFwqMeTPZMUyMmU70Ohn3u3omzjNn2inQeOEXrSfSnyZwNjNp8rruUmsH9F8f+
         da+JIOrHwc7xqjNLhMc0mVzPmJhARxbzwMpn5woR+zOf6IumqryNr1Q5t+ZvhbTg0eK3
         AxFPwEcPkZQ7RKrK0yc88Jkx7/Vdz1hC0HhiITu069PNSi6/qDFpPQB/djUCXrGSA8mF
         PPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8/tsUmK+L+AVrTCjUUiN4ztrNLnvqex6j+W5ttx8BT4=;
        b=lXZZStJrtcWm07KNd+p2UDnqCeTb84ZgAGTrjOV0RMgBbE4RxIroMCCpgA20REXlm6
         i8IItvYaRAqvRGRtE9FlPEAiCL2tuqjCEYsu5GlxOZa9dkN6kuGICIINAsMgh3rwQ2Tx
         lAo2IXZVrsqwGiFwgJhQ9k+RM6da5/Xt0IkFZ6Gkq2l4ItX6AqVhTwzPz2S/5+2/xfDd
         MjAgzF1Adlkf81DMgRdXvCDDgB7siHoSTnIZyCoKGokwyPQbINUjxL+mMxFSzCDvgqsB
         pz6EryvOtis3DWVRh6lEY+0eZ1xQG27B6mrk+tamCYeoFvbDS/2bF6YnTqmpczZ5UlDP
         B1Tg==
X-Gm-Message-State: AA+aEWZMhjeS2LVOV1GP9cmDRWnr9Q6Rbi03QRZoIH58bhk7mT6MyUEc
        vt1pmGSXaCHyb2evccm9P3WQEw==
X-Google-Smtp-Source: AFSGD/UKkRhCUDb6FIrLu/uMurusGTtNgmg8iXfekZzFAYiCxcAWW5fvi2v6uaBdHXtqMLh885qs/Q==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7-v6mr7565437plk.86.1542819535942;
        Wed, 21 Nov 2018 08:58:55 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:727e::5])
        by smtp.gmail.com with ESMTPSA id w136sm36555939pfd.169.2018.11.21.08.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 08:58:55 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:58:52 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com,
        jiong.wang@netronome.com, guro@fb.com, sandipan@linux.vnet.ibm.com,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 3/4] tools: bpftool: fix potential NULL pointer
 dereference in do_load
Message-ID: <20181121085852.31578bb4@cakuba.netronome.com>
In-Reply-To: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
References: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 15:43:12 +0800, Wen Yang wrote:
> This patch fixes a possible null pointer dereference in
> do_load, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./tools/bpf/bpftool/prog.c:1021:23-25: ERROR: map_replace is NULL but dereferenced.
> 
> The following code has potential null pointer references:
>  881             map_replace = reallocarray(map_replace, old_map_fds + 1,
>  882                                        sizeof(*map_replace));
>  883             if (!map_replace) {
>  884                     p_err("mem alloc failed");
>  885                     goto err_free_reuse_maps;
>  886             }
> 
> ...
> 1019 err_free_reuse_maps:
> 1020         for (i = 0; i < old_map_fds; i++)
> 1021                 close(map_replace[i].fd);
> 1022         free(map_replace);

Ugh, good catch and very nice commit message!  However, I think the
resolution is wrong.  We still want to free the old maps.  Note that
reallocarray() does not free the old array when reallocation fails, so
we just shouldn't overwrite the map_replace with the return value.
Like this, maybe:

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5302ee282409..be319c0eb94d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -846,6 +846,7 @@ static int do_load(int argc, char **argv)
                        NEXT_ARG();
                } else if (is_prefix(*argv, "map")) {
                        char *endptr, *name;
+                       void *new_map_replace;
                        int fd;
 
                        NEXT_ARG();
@@ -878,12 +879,15 @@ static int do_load(int argc, char **argv)
                        if (fd < 0)
                                goto err_free_reuse_maps;
 
-                       map_replace = reallocarray(map_replace, old_map_fds + 1,
-                                                  sizeof(*map_replace));
-                       if (!map_replace) {
+                       new_map_replace = reallocarray(map_replace,
+                                                      old_map_fds + 1,
+                                                      sizeof(*map_replace));
+                       if (!new_map_replace) {
                                p_err("mem alloc failed");
                                goto err_free_reuse_maps;
                        }
+                       map_replace = new_map_replace;
+
                        map_replace[old_map_fds].idx = idx;
                        map_replace[old_map_fds].name = name;
                        map_replace[old_map_fds].fd = fd;

> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  tools/bpf/bpftool/prog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 5302ee2..de42187 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1017,8 +1017,9 @@ static int do_load(int argc, char **argv)
>  err_close_obj:
>  	bpf_object__close(obj);
>  err_free_reuse_maps:
> -	for (i = 0; i < old_map_fds; i++)
> -		close(map_replace[i].fd);
> +	if (map_replace)
> +		for (i = 0; i < old_map_fds; i++)
> +			close(map_replace[i].fd);
>  	free(map_replace);
>  	return -1;
>  }

