Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F5ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E0A208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeISIkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:40:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeISIku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:40:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B41C93091D52;
        Wed, 19 Sep 2018 03:05:05 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9558C194BB;
        Wed, 19 Sep 2018 03:05:03 +0000 (UTC)
Date:   Tue, 18 Sep 2018 20:05:02 -0700 (PDT)
Message-Id: <20180918.200502.1787138156607502720.davem@redhat.com>
To:     zhongjiang@huawei.com
Cc:     michael.chan@broadcom.com, vasundhara-v.volam@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] net: bnxt: Fix a uninitialized variable warning.
From:   David Miller <davem@redhat.com>
In-Reply-To: <1537254944-41068-1-git-send-email-zhongjiang@huawei.com>
References: <1537254944-41068-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Sep 2018 03:05:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogemhvbmcgamlhbmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4NCkRhdGU6IFR1ZSwgMTgg
U2VwIDIwMTggMTU6MTU6NDQgKzA4MDANCg0KPiBGaXggdGhlIGZvbGxvd2luZyBjb21waWxlIHdh
cm5pbmc6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibnh0L2JueHRfZGV2
bGluay5jOjQ5OjU6IHdhcm5pbmc6IMKRbnZtX3BhcmFtLmRpcl90eXBlwpIgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+
ICAgaWYgKG52bV9wYXJhbS5kaXJfdHlwZSA9PSBCTlhUX05WTV9QT1JUX0NGRykNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IHpob25nIGppYW5nIDx6aG9uZ2ppYW5nQGh1YXdlaS5jb20+DQoNCkFwcGxp
ZWQuDQo=
