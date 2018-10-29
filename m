Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260CC2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAkEaFzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260CC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJ3Edj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:33:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38697 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Edj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:33:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id p86so4805284lfg.5;
        Mon, 29 Oct 2018 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a03GFk+k3fn8cFfh7Vk0sg8SsQ4UOnTnklmK8S4nQ64=;
        b=ZAkEaFzzfsRpdOu8ev1rj/y5h9mnfzjI6uV4biZNWhPVnmQPasbRWemzC5z1olekBB
         /goFRShx/h0wVH+eq0f0rjewD/7KZgf5m9hJ3nx9QWLnQIhHLwAe/xX1xCRS00IwVEpm
         wzXnG9UEZ7Hic/aDSO9Xxj07UFEK7peqdMDJsKDslXKDPT8ddkDhWUgIdNqkqiq/MON9
         8i6NPakSWbRifbEaEU0iqNM2gWiwDUQmQuEZMvZXHOLe25T9U5FF4G046427QHIa/XAw
         Dj5D/qA0zJmja3GBerlFJ6/mqzmoc7QGm/UFJhvfQb1or4iokz5smoLtRM6pLImyOoYR
         5qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a03GFk+k3fn8cFfh7Vk0sg8SsQ4UOnTnklmK8S4nQ64=;
        b=U4A232q7q71QNSEvzteXF328iqrH4XATYEDufUCRa+bx2td5IMNo1EGzbVfsUiiSXG
         /fHfZvgTDC+h1TdvrYbw9kcY2LYusgz8DC0d7XmECVXM2Bf2LD4JUypfJHmS6bV7MxtH
         4uSOas/hhBa7yA9lzyTUmsQJDcFJLDyCzTHj1bI3siJdWigNMzp0TSPIR7EHUi4V33O6
         GDSFiNCLJRujBbHCl7uZH0/7FRxORW4yNO8/HZ6IMLAW3vZHDjD40y6eWbpTr2bn6cqj
         KV33N1Sp1CcbirqUDMbU8w9r0uFX3J8dYpYfBlEN2U8M4RL3oNCdDEt/rxOmrpkUkw1A
         7SjQ==
X-Gm-Message-State: AGRZ1gIT2bqbHGpMq/uXHeN21lGqsDadrGKe7H/xAz3eD9giUW0QzjMn
        YmxTXDOxtqn043YGB2NwcBTf++cg0Iw=
X-Google-Smtp-Source: AJdET5f//X/mb0AnSNJ8dRTU1KRuTK0C4/oWsAeVzrfLg/sLUtdUjjZZ7Hnw6NNhap9hyTyGDmjb+w==
X-Received: by 2002:a19:a302:: with SMTP id m2mr56510lfe.108.1540842209843;
        Mon, 29 Oct 2018 12:43:29 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3426144ljk.40.2018.10.29.12.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:43:29 -0700 (PDT)
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
 <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
 <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
 <20181028055233.08fd81b0@vmware.local.home>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <4b4f1e05-0cf2-4b5b-55b1-9737cf0922ef@gmail.com>
Date:   Mon, 29 Oct 2018 21:43:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181028055233.08fd81b0@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2018 09:52, Steven Rostedt wrote:

> If a change log depends on other commits for context, it is
> insufficient.

ok, I will adjust the change logs accordingly

--
thanks, igor
