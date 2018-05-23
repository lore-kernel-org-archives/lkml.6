Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-467088-1527097289-2-9174643762809328770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527097288; b=YEHk2b6Nc7FOs5aWv0qHK8X4gDUfNI7YpjmnH/QBl4LztQx/7q
    fM5O3laUBILDJC5brVt4deKlV0SX9zFCTXe4K+eHCPC1GsuarBHiF/EaQ2ccxwrE
    PKnuePXkryVw3zQU57CjBrKrMwpuqjtzEOlEqZXwdfbEbNfep8f3XSPqaAuOfdoF
    ROdmrIYkUl4fiysbISLCJTkgaVpFmEjIx/825QVg6/mcuhwDV8JV9h/bhPxokFx+
    /v+E3qWX6DpZWQworwE7ajZkF7a/SjbJe6Ed8uCFpORtzckeIyOEiVvm5YnCns1x
    VYjXwvc05uIy1nq2SINrF9Pkv79+kZTid6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527097288;
    bh=GoJPxVZ0hUgLzUCFvSkX6oaU/fMcXxMsQr00vsvQoMU=; b=Y0MLuY84Cmd5
    6RGTqG76QiofuTfBHXUOspdWMSM4huEg8rTa7fso6GbOWDYznQpE7zolJmPkFEVY
    KMlRkBn108tVKrMAoVFe+HX3KARy9PO9CACJdulIg2LmmcJYqno9BkYV2ACrLOuv
    e2BIgihd/1M+hORbeadTekrb6AamhjTbUfbXDNkr5Tm9f75yt7Hkgt1+V8Eoh6rF
    AYRbJXdSIfyRA8oUICLSTFeEK7GGIbwIzjObUzfGsYUy1L54BKu6RuEosxsGGuES
    ph6D6atfwGoqIU5h94RCLRt3foEdHLISuPsq+krRRyLb+Di6hf+Zk7ExCo+X1wvl
    4nzK6Febvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJzCNByhGaeJ76yns/gR95c1sGjR7Ld2dL9n/dCd0KMmnoEIXYBKt0qgq/IiKViOrncVSEs/vhFgLb8YWdjZ5Q2ya7AzQQZIULyN6PmKWSypyDOXX30W
    v/zV5n2JA9voigLcoysAPRKtZ2/NWJ0FjaKNbSNG32VKhQKjzbzU9+nSIETOZ1Lj7FP4myXacQCuP4OJRsVImtOPC0Qz/VH8ss4ZVRUB2A0z2SDXRBpW7fgb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=3GZt3E5gixJeUKEhJDUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933817AbeEWRl1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 13:41:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49311 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932667AbeEWRl0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 13:41:26 -0400
Date: Wed, 23 May 2018 10:25:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: semantics of rhashtable and sysvipc
Message-ID: <20180523172500.anfvmjtumww65ief@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

In sysvipc we have an ids->tables_initialized regarding the rhashtable,
introduced in 0cfb6aee70b (ipc: optimize semget/shmget/msgget for lots of keys).
It's there, specifically, to prevent nil pointer dereferences, from using an
uninitialized api. Considering how rhashtable_init() can fail (probably due to
ENOMEM, if anything), this made the overall ipc initialization capable of
failure as well. That alone is ugly, but fine, however I've spotted a few
issues regarding the semantics of tables_initialized (however unlikely they
may be):

- There is inconsistency in what we return to userspace: ipc_addid() returns
ENOSPC which is certainly _wrong_, while ipc_obtain_object_idr() returns
EINVAL.

- After we started using rhashtables, ipc_findkey() can return nil upon
!tables_initialized, but the caller expects nil for when the ipc structure
isn't found, and can therefore call into ipcget() callbacks.

I see two possible fixes. The first is to return the proper error code
if !tables_initialized, however, I'm not sure how we want to deal with the
EINVAL cases when rhashtable_init() fails. Userspace has no reason to know
about this. The ENOMEM case I guess makes sense ok.

The second alternative would be to add a BUG_ON() if the initialization fails
and we get rid of all the tables_initialized hack. I know Linus isn't fond
of this, and in the past ipc has gotten rid of BUG_ON usage in ipc because
of this. However I mention it because there are other core areas that do this
(or call panic() straightaway). Ie in networking: sock_diag_init() and
netlink_proto_init().

Thoughts?

Thanks,
Davidlohr
