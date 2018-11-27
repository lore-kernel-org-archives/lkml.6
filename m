Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D7C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0VEzMLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D7C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeK0NC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:02:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44495 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeK0NC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:02:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7533974pfh.11;
        Mon, 26 Nov 2018 18:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yh945Ic/3FQsh11ZL6KFeO19zRvhVrinvK19Q8jN8Rw=;
        b=M0VEzMLGTLKYMmHrQBQ26KHtcqIO3KZSKoY+N2JV7zXAE2rVK8Y8JJRRCaJ27Z5TME
         Ef2o2Tb6KI6DQA1AJo2Vd0MQAiizgINWJbvgKkK92zKkkMvz0jf9u3SJ+5AvPJz46ZYn
         Pt/nnm4rrMzFQdLC2siF0wMzp8KYOLRhFr8OIWoytnurh9dR8FSoLPquP0g1+R9W13Pt
         piKCeJ94cqSUUG4hpHsrBOWcVwLOeM9cs+9H4L5VRvkWgWABO72B1UVNMWmsnYAXDe3x
         hgkVtjHeHv20dNazSh+bJFysfEI5yhZjBxQ81BsFvz3fpthYrqQBlWUeHdJgLD9mwQzA
         2qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yh945Ic/3FQsh11ZL6KFeO19zRvhVrinvK19Q8jN8Rw=;
        b=oqiACwjj+IBoBvsDwiD3ndSy6RpcmbgXs46Gihxs/8iNhEhi7ECXggGEyz13ff2b9z
         L5GXBm21GWRAkiArJSui7Dc16chTae1fUR0Hl+LrzgKroXf4ziusj/zJwB4Khr5xlfcW
         3elilvlF6GoGqwJLmsy0P/Do6IH50sAOY7BfXfUoUEr+i/wvwgRmcn7qqAycgsyt/w76
         4O1o2vVON5WG80vsqVtAxxR4vumVb1Xdk85wLYhL0o1wY/WTrC6A2O9C4RHD6JjLzXXS
         VfCT4199sFV7xeOW1NcJjnYnRW2BeZisphAGdLnujJDVPIdqC0sfP++8CM5h2bBxQoe0
         y5vQ==
X-Gm-Message-State: AGRZ1gI+9JHr7XkphvwI7zgOPp204UBPiMlyx/lSW16ubirwn1fyqQHj
        z67mg+/csCJPLGayIQvRONo=
X-Google-Smtp-Source: AJdET5dUpUaXs5UV5uVUqMeogpMmgdk1HvfULMKNiClTrzpIqcE/CHcgUy2tL9CyYH1Q8rJMW5+RHw==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr30171349pfh.188.1543284372909;
        Mon, 26 Nov 2018 18:06:12 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:c233])
        by smtp.gmail.com with ESMTPSA id t66sm2316650pfd.54.2018.11.26.18.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 18:06:12 -0800 (PST)
Date:   Mon, 26 Nov 2018 18:06:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Aaron Conole <aconole@bytheb.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [RFC -next v0 1/3] bpf: modular maps
Message-ID: <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
References: <20181125180919.13996-1-aconole@bytheb.org>
 <20181125180919.13996-2-aconole@bytheb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125180919.13996-2-aconole@bytheb.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 01:09:17PM -0500, Aaron Conole wrote:
> This commit allows for map operations to be loaded by an lkm, rather than
> needing to be baked into the kernel at compile time.

Nack.
Please see Documentation/bpf/bpf_design_QA.rst

