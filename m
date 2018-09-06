Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C73C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3L3S9l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF94420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeIFWg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:36:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39959 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:36:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so5331546plp.7;
        Thu, 06 Sep 2018 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SnM4QPOzWInG5LlMjFmDG3Jwwdd7H2um00Ygv/f4vg=;
        b=k3L3S9l3mwZjHmZF2mHbWZIULTojYdrL4u1VWuDFdn/WAfOgXYvnVurabxW3g56e7D
         aukAJpncTP3l97M9/edNmGC0a069mTb2ugPfi5E9VPewJQAa9I4SJeC7HSBIiBPLxEo1
         BIWssQdmxp6NGTTPHOHqYPRNICV5S4kB5sUu0pT5zpFB5bULaiEY4mvt6JmdzZi86Og4
         zLRxc2OlGWxa7vOxBMWTWj8CQKqcC36bSVyyqrAI7uVB/H2qF5o4OYWu8mkkyh+b4Wk2
         UYU1Gdm98znPEiUzXbPiARiuT/R1ZylDWNTqjUuewIuUL/fo9SKBIw0M0LyFeSCnut1b
         8UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SnM4QPOzWInG5LlMjFmDG3Jwwdd7H2um00Ygv/f4vg=;
        b=Q+sgZwGoSME+lOr/2F7/o/E+kIWndqIkx5IoVbJZOQ8ZkavkJFMIbt2zhLAG8slGrq
         38fb9iXuTuDNIUxqT2bCzYIHhwmHTgl6ZLG9elTr7wtJDU8/JH25/RHWjzg/gqBnabeS
         QrWUay77AcR4v12DH0b/avCaUWpxUAhO2AxvoFwQKFamnQsR3QUZJ0IrYBfYnQOTEy3B
         2fr+c6PzmJk8f+cN37nK/16ZDmkuXVqv0ABB8paiN0j9x0Ij2tcYG4j/1rDaXbdXHLlt
         6mLA9NDS3dB3nsy3+WYM0YyNyGO0AUZ8ZhbWlNNcgjs219ZvY6BpT5ik1y2nIgL1MuLf
         knRQ==
X-Gm-Message-State: APzg51B96p9MkrFwGHtOODzSNKmk1rxmw3WBiPcc7D7T5azTHrn4uWTs
        073FGQSm7FC86a0XIYOxXypTxz/v
X-Google-Smtp-Source: ANB0VdZiU5EXpTDpzKfXSPZ+6+xy8AUWgShq9ZhVSxNpzVQX22U1BzZGeYxf7pz58YRYWCkxJzsCRw==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr3912040plb.297.1536256822696;
        Thu, 06 Sep 2018 11:00:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:7a4e])
        by smtp.gmail.com with ESMTPSA id m21-v6sm7814858pgd.6.2018.09.06.11.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 11:00:21 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:00:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mauricio Vasquez B <mauricio.vasquez@polito.it>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf/test_progs: do not check errno == 0
Message-ID: <20180906180019.a3u4tw322qhfkj3v@ast-mbp.dhcp.thefacebook.com>
References: <1535994119-4853-1-git-send-email-mauricio.vasquez@polito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535994119-4853-1-git-send-email-mauricio.vasquez@polito.it>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 07:01:59PM +0200, Mauricio Vasquez B wrote:
> The errno man page states: "The value in errno is significant only when
> the return value of the call indicated an error..." then it is not correct
> to check it, it could be different than zero even if the function
> succeeded.
> 
> It causes some false positives if errno is set by a previous function.
> 
> Signed-off-by: Mauricio Vasquez B <mauricio.vasquez@polito.it>

Applied, Thanks

