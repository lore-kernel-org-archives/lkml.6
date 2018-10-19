Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6187ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610F121470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFBqvgw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610F121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJTEkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:40:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37260 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeJTEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:40:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so16968549pfi.4;
        Fri, 19 Oct 2018 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojfX3pbjHau1Sa5EYhD5POUEs73iqTiRBRI1SEyzuII=;
        b=oFBqvgw3P/V1sJ5+nGEU1FsOYbZIap5JoKiOL108XELUlLnMfyA1xHj5qf6tL9cg1A
         uYByz1jbVGTC05wXWSgQy2CwuAIdpHlRPmPhu/PF/4x4fsCc5d4zt4nNg8DI+gf3LiHj
         K8yAgqu94wFvKpamhXFKtOg0qw2CDPyNuyIHknL3XAVlvtEKTLLh249fqgpxa1n5esxa
         2Sklz7zRKTn82Zz5iKbo0qa4J0Epmqg97awXno8C0TzRlK8UXR4cCpn4KMpXH+JUQkA+
         iRR+XDqchP0Foqm4UNNhYedc8DSMdwi+WVGKiJERIXAn0nAQ9J/pJ4Sq9KYw59w6Cufj
         e18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojfX3pbjHau1Sa5EYhD5POUEs73iqTiRBRI1SEyzuII=;
        b=ri4k9LCxzbPj9CM9mmWQqPVzNvcX2fAEZJYV946JGR+DCmQIFjA5rmhr0j5vVjbxEf
         0r8qgaPySxNpyrozi3y9597Jr0GeN7eEJvAorC7JaKYldPUaq48WHKOMWT3UWCTP60MG
         s5/0oUuYTtyKb8LjYGc0DI7saNDjKkOBTFInlpWzX5Ox9JpJDkV91RRryxF6HZ+xj/qd
         R6tM44Ws2hKNcwFm24XAXQLfnIxPm/IbfbNwjg2q+4MH1E6oIxKO+08DGxuytvGh0mjN
         S5r4q6qGguE765oJRAd/2eFDgOwblpn515ga6S+PbwsNFiN7nn8Xm6g8N6yOFry6u8Y6
         KJdw==
X-Gm-Message-State: ABuFfojDrBspHg3cId/XYc04Zc0MHfPc33IdRyKb2FqAjlNVw3YB93t2
        lUTRDAoHgtqJoA3OYJvURpA=
X-Google-Smtp-Source: ACcGV61HC51puXHV2++41aqjWL4NXP5YmckBXKnU8q+d3OD55vYzr7ixrrK8GmQzc2IuiJq/fW8uPg==
X-Received: by 2002:a63:8e43:: with SMTP id k64-v6mr32860024pge.75.1539981177820;
        Fri, 19 Oct 2018 13:32:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:388d])
        by smtp.gmail.com with ESMTPSA id b81-v6sm43887726pfm.96.2018.10.19.13.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:32:56 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:32:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: add missing executables to .gitignore
Message-ID: <20181019203254.kjhdmws2waffhhue@ast-mbp.dhcp.thefacebook.com>
References: <20181019142436.2955-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019142436.2955-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 04:24:36PM +0200, Anders Roxell wrote:
> Fixes: 371e4fcc9d96 ("selftests/bpf: cgroup local storage-based network counters")
> Fixes: 370920c47b26 ("selftests/bpf: Test libbpf_{prog,attach}_type_by_name")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, Thanks

