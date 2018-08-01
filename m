Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089B520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw0HjeNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089B520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbeHAKNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:13:36 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40941 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387836AbeHAKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:13:35 -0400
Received: by mail-pf1-f179.google.com with SMTP id e13-v6so7471994pff.7;
        Wed, 01 Aug 2018 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u5VhfdgDn04a9GD5iPt4Mu70MTNBTOj6OhGSXRFGVK4=;
        b=bw0HjeNQ+HdPVub/7QlqNnSyu1LVhWG5x2KjLlQvEFae8Gc3qNsT9RaIgupNXi42AB
         YLSrgNOCyX5Hx5lLY8YdqVWHAMWsWiwYcbf+GJHOg23ktRVWZ7q6q+4MJe9Ab6WrkZiZ
         1ZlfG1QB4obKTKeLDNUJ9OHjIf07+mtpDjg3OH29bkp/l35dSAY9TMM/EiOdxthQafZ6
         nvb2eF80heD7lf66TAqZygyE8LGIzV5iLj5Y8TY6HemDatu+MX3oEqo9TZXw3iU7f7aU
         y+xTyaEVupS2OrU7ygtyt1oWwAF57z1quvreBsGcc6+pipm8ZccEupYUmcsoCSv0vGTo
         cnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u5VhfdgDn04a9GD5iPt4Mu70MTNBTOj6OhGSXRFGVK4=;
        b=s0jPHVsTSvS/X8luLIdsBcq8ED//t1oJ1b87etplhdObR7uVWR1mKNm24rmNNae5U/
         AqHz94rlffucN8mXpIDvdKEx18unwprudlE5iZUf+tvjHzQ8qHLjC048Kw4bicK9lYn3
         cYUCzBzregXQc6S9tidytLofGbIOYM9Elo5tgU9RCkbYzaqUwA81IU3Jgt2jTGd7BY4F
         TQNbvy+FyqvOHpwfrRmmdaedBPwo6JrTEdwej0j8vNeqsPg2Gylzb+4W72aSJ3G0zqBS
         l26TBZPN0yK/FE01BeTvxtOQBEOmSMFe5NfZ2OABGTw7hiEYXOjMmk5Wvu+gVXfnSktF
         4oug==
X-Gm-Message-State: AOUpUlF/6MiVmNxmjcUG+cLbrao/8v8LR6+bHSgw4KvB6kvSLYGp0zON
        Ri/2N2Q6H9bxb57MNF+hhNg=
X-Google-Smtp-Source: AAOMgpcjJUcXI+DDjLRnrtCJg80jXg44VTNciRc2/PRyWwp7nzxK5sK/drcoIU6rg88VY/JMuk3X3A==
X-Received: by 2002:a63:ba43:: with SMTP id l3-v6mr22885647pgu.295.1533112141543;
        Wed, 01 Aug 2018 01:29:01 -0700 (PDT)
Received: from swr12sw01.cumulusnetworks.com ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id j22-v6sm21707658pfh.45.2018.08.01.01.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:29:00 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
To:     Sabrina Dubroca <sd@queasysnail.net>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lucien xin <lucien.xin@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004fe2be05724ac084@google.com>
 <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
 <20180731134014.GA32114@bistromath.localdomain>
 <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
 <20180801081537.GA31982@bistromath.localdomain>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <18196855-1085-9c70-fc58-fdcbe4060d21@gmail.com>
Date:   Wed, 1 Aug 2018 10:28:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801081537.GA31982@bistromath.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 10:15 AM, Sabrina Dubroca wrote:
> ip -net peerA route add fec0:B::/64 via fec0:A:: mtu 1300

I am on vacation right now with limited access to internet, so not able
to take a look.

In submitting the fib6_info changes I did tests like this and did not
see memleak reports (and verified the metrics refcnts with printks), so
I am surprised to see your patch in this area. Will take a look when I
can but that will not be for a couple more weeks.
