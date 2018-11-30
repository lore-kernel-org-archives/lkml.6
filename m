Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDE2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBDE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeK3Of4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:35:56 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35411 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Of4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:35:56 -0500
Received: by mail-pf1-f177.google.com with SMTP id z9so2087106pfi.2;
        Thu, 29 Nov 2018 19:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2SGDMtSnDzawD8L/WpsqYzbqbEIipLqFW4fipDJqSdc=;
        b=IKwtiXp1pD+C0Vk3s2YQz8WVkx8YSYATGUNwP3Ek6vpDuxRLSYFby44NxgvPAX3oe3
         wz3xEPpN8iBqcVoto2OPDCNJOSR8C0LLi9k6lfeWVEjJvi/O40Ni69xccGlM2HxO1gFo
         gn3KEVxlccbT0ryvlx8eVw0alzBceGyCiS7MPUwHLxtLFrrqjfs2ln5YujzSZRduaIZu
         i6nIMgTvsDWt2eizgj/bc9pc1hhZ3hA3EPHOUjadwV9yWbS3YSB49xlgth4z5T8JYC0B
         1t84cOuA+yi4BImd7padhEcPiVbqKx+oFRixigcY7okk8dmaeY199ibN3f67aomT9VRr
         86pA==
X-Gm-Message-State: AA+aEWaVYNpMMSdj/6XXIFetUskwaP5bE+lvjF/1ReT4gYEroP7bSphT
        yOUw7T62/1ZGvHwNQ/FpiRA=
X-Google-Smtp-Source: AFSGD/XRim67wJhFQN4Q9x8drZqHCeWTyjPbdvBdIZQrIe2CGkr8mMYDzbNXaIIk0Gw/2trRv0rzAA==
X-Received: by 2002:a63:2586:: with SMTP id l128mr3543015pgl.104.1543548486406;
        Thu, 29 Nov 2018 19:28:06 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id i193sm4291427pgc.22.2018.11.29.19.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:28:05 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:28:02 -0800
Date:   Thu, 29 Nov 2018 19:28:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181130032802.GG18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void kunit_run_case_internal(struct kunit *test,
> +				    struct kunit_module *module,
> +				    struct kunit_case *test_case)
> +{
> +	int ret;
> +
> +	if (module->init) {
> +		ret = module->init(test);
> +		if (ret) {
> +			kunit_err(test, "failed to initialize: %d", ret);
> +			kunit_set_success(test, false);
> +			return;
> +		}
> +	}
> +
> +	test_case->run_case(test);
> +}

<-- snip -->

> +static bool kunit_run_case(struct kunit *test,
> +			   struct kunit_module *module,
> +			   struct kunit_case *test_case)
> +{
> +	kunit_set_success(test, true);
> +
> +	kunit_run_case_internal(test, module, test_case);
> +	kunit_run_case_cleanup(test, module, test_case);
> +
> +	return kunit_get_success(test);
> +}

So we are running the module->init() for each test case... is that
correct? Shouldn't the init run once? Also, typically init calls are
pegged with __init so we free them later. You seem to have skipped the
init annotations. Why?

  Luis
