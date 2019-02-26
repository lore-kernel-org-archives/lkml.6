Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3573A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brT4IZT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBZJLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:11:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44382 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:11:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so5917209pls.11;
        Tue, 26 Feb 2019 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52U25cht0zHiNRNh66FwIqUZB8W16/yFRaq8MAGOCOU=;
        b=brT4IZT49cG3cNpB34W0WTCGNNyWgaRmCghM7Ld5fwuKwmG2Q3ie1Ut9kNuiysILp8
         EuWevQodHiQQDqme6eBezAluYSexQy/p31JYak1Ng/4RBIsT97Arl9sMxiU0Cr3vB8bV
         ip3iEsWEsV3hX+65RxMkO9Rm7m0Fbe+HvHnFC7DFkJ5ClaiVvVtS92yHJm7YgTXP/zym
         Hu80xzcJd9EucCvufczkTeCRuiuPonJMXCs9h8U93jVFTbXRr0yUsTKNDOhwK08hJ043
         8zzTIaAGS5yVheDT5EUwKOwxZR5n1DPTvAGr6YY3x5RZRLt7NC9jqymckoqoOVzpluTI
         G4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52U25cht0zHiNRNh66FwIqUZB8W16/yFRaq8MAGOCOU=;
        b=QUJKuRqI1f5PbDrzJibKCO8auguU9PfEysi5xthNRroHtsmLP9STyxnttTwNrp86Sj
         3gkeWC5krAvMMaWgce7/HEvSrHheYDQm2/QZZBaQ4dH4uSO/z0R6mc1yZ2VVF1/8osKM
         POZgSGT5UbHiijCpoLue1panxVzgy3NzTQy5cxZuLCbG0rkVC8urHfUn216DiZwHHsJY
         WNKDIBNQG7xfQaLEdK8uzM35Bho1hvAbdqZsrOMcy6k6z+p/J7AR+UNdG0sbomsuZDFl
         bMv22stgzm/PAOtvJ6qCNQG9YRLSldrw1o89NAL6dU1riVqDUsPhJRDUkWP85sLT4Qkz
         P5KA==
X-Gm-Message-State: AHQUAuaaihWqqSskbGvLJCJd5DTebZTXAfKmyQF7Ih+PvHiLDz3JtfNP
        XYgdky+t9Iw3FAlHbtRLaXtVVphu
X-Google-Smtp-Source: AHgI3IYJsWuZLdMsfEtpdNo1WHAYWPn5+IRJwFT+8G1ULwQLFHd+R2JG8/cBs1MpLh6Rjib6bS0yjg==
X-Received: by 2002:a17:902:5992:: with SMTP id p18mr25035122pli.231.1551172280717;
        Tue, 26 Feb 2019 01:11:20 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f87sm268454pff.38.2019.02.26.01.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:11:20 -0800 (PST)
Date:   Tue, 26 Feb 2019 17:11:18 +0800
From:   Geliang Tang <geliangtang@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: add NULL checking for
 key->type->instantiate
Message-ID: <20190226091118.GB3197@OptiPlex>
References: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
 <31395.1549492013@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31395.1549492013@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:26:53PM +0000, David Howells wrote:
> Geliang Tang <geliangtang@gmail.com> wrote:
> 
> > key->type->instantiate can be NULL, add NULL checking to prevent
> > NULL pointer dereference in __key_instantiate_and_link().
> 
> Do you have an oops report or test case for this?
> 
> David

Here is the test module code. Insmod it, we can get the oops.

#include <linux/init.h>
#include <linux/module.h>
#include <linux/key.h>
#include <linux/key-type.h>
#include <linux/cred.h>
#include <linux/seq_file.h>

static int test_instantiate(struct key *key, struct key_preparsed_payload *prep)
{
	return 0;
}

static void test_describe(const struct key *key, struct seq_file *m)
{
	seq_puts(m, key->description);
}

struct key_type test_key_type = {
        .name           = "test",
	//.instantiate	= test_instantiate,
        .describe       = test_describe,
};

static int __init test_init(void)
{
	const struct cred *cred = current_cred();
	struct key *key;
	int ret;

	register_key_type(&test_key_type);

	key = key_alloc(&test_key_type, "test",
			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
			KEY_POS_SEARCH, KEY_ALLOC_NOT_IN_QUOTA, NULL);
	if (IS_ERR(key))
		return -1;

	pr_info("keyring allocated successfully.\n");

	ret = key_instantiate_and_link(key,
				       NULL,
				       sizeof(int),
				       current->cred->user->session_keyring,
				       NULL);
	if (ret < 0) {
		key_revoke(key);
		key_put(key);
		return ret;
	}

	return 0;
}

static void __exit test_exit(void)
{
	unregister_key_type(&test_key_type);
}

module_init(test_init);
module_exit(test_exit);

MODULE_LICENSE("GPL");
