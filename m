Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B721887
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6B721887
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeHMSev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:34:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:34:51 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 89B071458045A;
        Mon, 13 Aug 2018 08:52:02 -0700 (PDT)
Date:   Mon, 13 Aug 2018 08:52:01 -0700 (PDT)
Message-Id: <20180813.085201.1107715561650084682.davem@davemloft.net>
To:     xiliang@redhat.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen-netfront: fix warn message as irq device name
 has '/'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180811152137.3627-1-xiliang@redhat.com>
References: <20180811152137.3627-1-xiliang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 08:52:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWGlhbyBMaWFuZyA8eGlsaWFuZ0ByZWRoYXQuY29tPg0KRGF0ZTogU2F0LCAxMSBBdWcg
MjAxOCAyMzoyMTozNyArMDgwMA0KDQo+IFRoZXJlIGlzIGEgY2FsbCB0cmFjZSBnZW5lcmF0ZWQg
YWZ0ZXIgY29tbWl0IDJkNDA4YzBkNDU3NGIwMWI5ZWQ0NWUwMjUxNjg4OGJmOTI1ZTExYTkoDQo+
IHhlbi1uZXRmcm9udDogZml4IHF1ZXVlIG5hbWUgc2V0dGluZykuIFRoZXJlIGlzIG5vICdkZXZp
Y2UvdmlmL3h4LXEwLXR4JyBmaWxlIGZvdW5kDQo+IHVuZGVyIC9wcm9jL2lycS94eC8uDQo+IA0K
PiBUaGlzIHBhdGNoIG9ubHkgcGlja3MgdXAgZGV2aWNlIHR5cGUgYW5kIGlkIGFzIGl0cyBuYW1l
Lg0KDQpUaGlzIGFkZHMgYSBjb21waWxlIHdhcm5pbmc6DQoNCmRyaXZlcnMvbmV0L3hlbi1uZXRm
cm9udC5jOiBJbiBmdW5jdGlvbiCheGVubmV0X2luaXRfcXVldWWiOg0KZHJpdmVycy9uZXQveGVu
LW5ldGZyb250LmM6MTYxNDoyOiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2YgoWtz
dHJ0b2ludKIsIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3VsdCBbLVd1
bnVzZWQtcmVzdWx0XQ0KICBrc3RydG9pbnQoc3RycmNocihxdWV1ZS0+aW5mby0+eGJkZXYtPm5v
ZGVuYW1lLCAnLycpICsgMSwgMTAsICZkZXZpZCk7DQogIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0K
