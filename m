Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3018824-1523342225-2-11978477749468368519
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523342225; b=iJKIuK7bomU4Qk8tj6dGZ9FZieTC9ReBEM85SSSAjNFPVKf321
    ku+Se0N4ehVIujcmN8D3JQNweszhxUxt4Bg0PF6llJClMtJ6VgxVpBL9Xshnp9+K
    nJWyu4cBgwIe1WFiSfYYr9+rerptnd4F8luCT2E9tVrYtUtsPZ0pUs38vh7zynG9
    S/TW+Aqax9v0oDj4qYQrI8RawR+2kVfMXwmiiTuY4jiAuQhZp1b2OyEwyFGvx2F4
    DV3vKJxu50TueCmKhlOfy7lH/Um0Yi+wNuHSBCQkTEnYF2ZdNAfQ1FNXQitMV2vm
    QWNs4g2BWFWQXHsb3gxEtW/TRETvG3+hsiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523342225;
    bh=P6f5UMVwXvayMZD78qOQ2MofzXNvtkoG5X4bMCYSc7g=; b=eLPbEbwhLanU
    2dwdTYXR4uJg6LpRiAqoYNdsgZzUor0EFWs23eAOrm+4Km39ge+AuaVXdp6PUuXE
    TYWiuqNPPYfC/QGs/SromMYyQv/CvFWmBTzCYB0v/fqrXY/SScGu2wz0a6L61K3t
    /5nC6udkm4flQNDjK5GAimPNCi6y/1qln32eUA2cL7wUevHjRvDoM6hq5ugkFFjL
    95l2Wk6VL/rGGPkZtVr/vtGgv4P0CfTYQC879YVUO4q+TRkGZ8Gz5GbgKPu1qHf1
    nI/P6cmYusM6g6BHsa4ch1BFRRy/awIZ5GqoHRwIxwyFi/FDVsEI/GQPxQS7wqsa
    3dfBfwPiKQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJICuCnh0rpGow8iXcbeAXG250o/MDapsrdxnD4GJVyczTqUl6XdLSLRaKGNGwxt8lPFoJEfhM0Dq5EI7UPmKeRSB5mIGVPRO+q7oWrQhOatyqjTB046
    qHHYuMVnGKXKVRDz2JX74mchK0ClQq+jHIvdoincaqXw+555FaUG464ePEfbXOqzw5IgRjMsVYX/UQU5S5AHqm+K2Kj62oQHDUo1CZ2DX3oIIipMck4j96K2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XbGvyVyP7asA:10 a=N659UExz7-8A:10
    a=Kd1tUaAdevIA:10 a=JcItvG89Ojpa-aYotwIA:9 a=pILNOxqGKmIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDJGhC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 02:37:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60096 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751845AbeDJGhC (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 02:37:02 -0400
Subject: Re: [PATCH] f2fs: don't use GFP_ZERO for page caches
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <stable@vger.kernel.org>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
 <fc31dd88-5dbb-1c37-28fe-dfef09cc448c@huawei.com>
 <20180410035022.GB47598@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <36393b5a-9b99-4304-c077-09288219dfad@huawei.com>
Date: Tue, 10 Apr 2018 14:36:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180410035022.GB47598@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/4/10 11:50, Jaegeuk Kim wrote:
> Actually, we don't need to do this, since fill_node_footer(true) will reset the
> page.

Yes, confirmed.

Thanks,
