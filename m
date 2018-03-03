Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941094-1520068759-2-14141844219657049929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520068758; b=YpO7NyMr467/XIb6+Qie1nlQQ5td/38QKlTVfkleLCiGipt
    H0Wk7qWdJ673JkG7KQ65snXdFFlhqVybgjVnStKqH2+GqBhixZT9Fw9wRGB8lv8p
    54PlApji/ZPisTlGrrkZ6vEmBiZgnyzxp65tRAPfF7EVTh65KpGGVc90/FUkoIY1
    CgupW+MUfwhxO0O3GHxTOEWve0WUAFew/iM3zgQLRtvn/RLZ49hq1Kd7T4g5i6EI
    dqnHW4C4EO+ZUu3bnPDjuBMs/N+aZHASmpBSpAJ3GfNbiHZ8ETQcSeyCKP/UoAzH
    XpF7Fb8ADsxE0KncExXp4NcMkNfPtY6pNvU8yDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520068758; bh=GQjUqOXWSJaZF5vM3Tl/8fKCtE
    QXwmPQIxb79NXAw+c=; b=MDgxSPLThSA9ckCEqf7BCmkdfUmkJR/1ov74d9Scvt
    pAF4sX+g4LS98KEgKFj1jnSe0Qnafh+Vo6Q5FrZox4m1nXlz9pwe5Kh2HdFJtdqb
    wckOhRP6ZXY2xIznd5CFE+l3SlL6sJ4lP6mKeJ1GXiWv4satNytJXXT/EjmSeNYD
    IVejxdfUVK5c1d4kPaJ6lWzUdxugJXz1sV/v9VGKIEX9MXMIRk7bKwgsS2uLoprO
    oBF855R6okW0w3Gkc9ebm6G91NnBhkrJ6cRA79VIPGTZb7Zzo2Sv3pDUFV/9lVVK
    pfRgyL7mSRUXd5mAt1huvuHYtRWVSXfvC1LHNK4MDzpg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeCCJTQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 04:19:16 -0500
Received: from h2.hallyn.com ([78.46.35.8]:34478 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeCCJTP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 3 Mar 2018 04:19:15 -0500
Date: Sat, 3 Mar 2018 03:19:13 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, trondmy@primarydata.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180303091913.GA13118@mail.hallyn.com>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:41:04PM -0500, Richard Guy Briggs wrote:
...
> +static inline bool audit_containerid_set(struct task_struct *tsk)

Hi Richard,

the calls to audit_containerid_set() confused me.  Could you make it
is_audit_containerid_set() or audit_containerid_isset()?

> +{
> +	return audit_get_containerid(tsk) != INVALID_CID;
> +}


