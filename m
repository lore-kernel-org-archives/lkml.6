Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A73FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78582075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtHJUaPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78582075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeGQTgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:36:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37609 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQTgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:36:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id a26-v6so951873pfo.4;
        Tue, 17 Jul 2018 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ldvO+jgqLWwJPNAzX4H3vUxbDijlWzwNyDW88/cWLuU=;
        b=AtHJUaPxHVtCPEyEMbDqOlV6Lf8CaoySvnHl1q1mW0vjb4ahlxhrq+EoGTkO6OTiXg
         u66uZ4Lyk+eIl4UXgAbg7Iagn0BedXcKWBpzx44dLKg0BvPhAevPcq+yNABL0NdNk2IO
         nqukcDl/1kTYvfWf1uAoSe/7H3I7sseILSuOFfOXJPxVKfXIpfNttHZAHdk12G96Bisi
         jvwnlt62tKv+H6TSu36v+s6AlXUKj+I6mqT8bNbmu2shbE50YHeTHlQSNmjQHE1VYtG8
         rjwr2/YBh5opasMvgF+c8Z0mGG8SMe0kq30qYEwSVZrsPW+iuL5HmQ13CQWjBHBnN/1o
         RajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldvO+jgqLWwJPNAzX4H3vUxbDijlWzwNyDW88/cWLuU=;
        b=Tjs/4mIusAH4F4xDm2UMBJv21E5OYcb3ih1mskZ7gACfrS9uSCQ0Wc7fcc/AC8bdnK
         uPMt6YMPxQSIm7dp6G1kuTNp6TjltJWfjx2DvXhnW0OxWQCy2glpRCK4zwdFhOel1vd+
         jbJMc5JXi2dblfvjky0LKkFk+OMUvEGUDINQ1XPihsxCWH82i7Me+jxHVSS4VtAoRbl0
         RcvdV/bCU+ZqaEH2IkZY6qTAqPVNYO8t5kLwfJZ2uORg9hgT6VKYAT9ZseH41hTgDJ3u
         Vf3aagm7GTeqvsWl7NKriYnYMM/F9YtylfoFU6NI7qg9JPr18TE+DqAuO9UGWpAux4uU
         ZM1Q==
X-Gm-Message-State: AOUpUlGr2OCdi8LKgq1O8x0o2UtmFQkQ8kxA/IgfTjyHS91XHRYUGTnX
        Nh8ZJEbr+Eu3JppeGQ0WOCBdRaEm
X-Google-Smtp-Source: AAOMgpfqTwLB/815T9vYtvDSfbkF5qhvCh7hDAazDAlGxmi+lIiJTRf4th7O4kPwE14SS2Piomo58w==
X-Received: by 2002:a63:5542:: with SMTP id f2-v6mr2413563pgm.37.1531854141797;
        Tue, 17 Jul 2018 12:02:21 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:442b:d01f:635c:39ec])
        by smtp.googlemail.com with ESMTPSA id 21-v6sm10229836pgx.20.2018.07.17.12.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 12:02:20 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
 <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
 <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
Date:   Tue, 17 Jul 2018 13:02:18 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 11:53 AM, Cong Wang wrote:
> You can see the original discussion here:
> https://marc.info/?l=linux-netdev&m=140356141019653&w=2
> 

Thanks for the reference.

I was surprised that the tables are still global. A number of objections
raised in that thread were due to a large patch tackling multiple
issues. This set is focused one thing - moving the tables to net - and
does so in small incremental changes to make it easy to review.

One of DaveM's comments:

"Finally, another problem are permanent neigh entries as those cannot
be reclaimed, that might be part of the main problem here.

One idea wrt. permanent entries is that we could decide that, since
they are administratively added, they don't count against the
thresholds and limits."

this is another we have hit and with same thinking ... permanent entries
should not count in the gc numbers. We need to address this for EVPN.

As for the per-namespace tables, it is 4 years later and over that time
Linux supports a number of features: EVPN which is very mac heavy, VRR
which doubles mac entries (one against the VRR device and one against
the lower device) and NOS level features such as mlxsw which has to
ensure mac entries for nexthop gateaways stay active. In addition there
are other features on the horizon - like the ability to use namespaces
to create virtual switches (what Cisco calls a VDC) where you absolutely
want isolation and not allowing entries from virtual switch to evict
entries from another. And of course the continued proliferation of
containerized workloads where isolation is desired.

I understand the concern about global resource and limits: as it stands
you have to increase the limits in init_net to the max expected and hope
for the best. With per namespace limits you can lower the limits of each
namespace better control the total impact on the total memory used.
Perhaps the defaults for namespaces after init_net could have really low
defaults (e.g., 16 / 32 / 64 for gc_thresh 1/2/3) requiring admin
intervention.
