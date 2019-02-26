Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01BC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0896C20643
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCQTUdVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfBZJJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:09:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36760 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfBZJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:09:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so5920688pgr.3;
        Tue, 26 Feb 2019 01:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52U25cht0zHiNRNh66FwIqUZB8W16/yFRaq8MAGOCOU=;
        b=pCQTUdVXRjdN2oHcSwJV1KFOqwZqKklngD75ks+Uu9IwXl5ZuHSmuqanlhvIyX9wjY
         p/MthjObBgkzoiZNpZ17efB7XfFcU+mf/wW7H6AkzGGsCV+6HKw4/4BawF27dhEuUBhu
         F8eqprbPejNaSyGY3NCICTrHmIx1fFAOqtMF0VuzzAEPUlriiOgmSLcZTwr3TN7JGs1f
         LmAgdLm7f7IP5bUoukLsCu0H8MSZaB7DuYsZAnV+pLxQNItI+CE8lx2uuLmrDBoeqIL8
         T/tLZJrfPeJlhhr1ybpSoaIs5tdJVUIAqvNa1f3RaPr5ix6RIpooaULY7Ozj+jTFAu2M
         uKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52U25cht0zHiNRNh66FwIqUZB8W16/yFRaq8MAGOCOU=;
        b=HQfPd9tYw7bLBttM8gHLjHT9HHJ+JPMovb1tEI5ek1PmPf9rr9qmVNrX2dYjblh6zX
         kDsK2nMWjdSDn9NFdv9m8+5X22OxhOkTgqkvTNwIcemVyQu5KhzdhUoDDwQJawUOCQSO
         3LPdVcLbaRlAUn12Vv+zhxzrfRn4ojCQA94nYtHOhhpj9e7ANEV+RybX4CKIvNNlnAOp
         Ffqcsc00UQDN9o/Yn676E+mZoD6YfHrt6IxBHlokOw7BDkU7r5Fow0GF9jDC+v1dgoGb
         B2geKdL+ZxJ3yesyBGUzkpOqR7EUUryS1tm1LGhzP7OudrbCWQ3pQh8KKeTObZ5oh32u
         myzg==
X-Gm-Message-State: AHQUAuZkA6Yb1S0AD1hj17bbvuO+fMcvM9bCWQDW1YP3IUZ0vxN/2njX
        Dlb4dkrNVOjRpwmEr73agaw=
X-Google-Smtp-Source: AHgI3IbEeDLnZ1SbUP9xbqKEIlqYWIaU40ROwPIqoMi89NWKZrP4A+ZgzNRLL4k8lQ9do0aV0fZCGg==
X-Received: by 2002:a65:4147:: with SMTP id x7mr2711647pgp.54.1551172145673;
        Tue, 26 Feb 2019 01:09:05 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q5sm18093662pga.71.2019.02.26.01.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:09:05 -0800 (PST)
Date:   Tue, 26 Feb 2019 17:09:03 +0800
From:   Geliang Tang <geliangtang@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: add NULL checking for
 key->type->instantiate
Message-ID: <20190226090903.GA3197@OptiPlex>
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
