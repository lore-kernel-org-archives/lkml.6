Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F42C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5372081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DssgENGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5372081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeK3AA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:00:29 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57454 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK3AA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:00:29 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6B82324E20DE;
        Thu, 29 Nov 2018 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543496113; bh=TJG/pkvYmKC3+WfVyuU6/fUipnUzKKjO0ChtQRgB5b4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DssgENGH+uomJimmWsjMUXM11+TiqljYsyFF22M5BvQWGpu/q3FsyGJXp2y6V3vv3
         F2Jh+/5mztPx44gmZz+RfYMfANeWr5grN1ndVqkv0fR7QwxxDRr9EoqTNo+rMfwGrx
         Jrnahy/K/85diQscDQo4qGy/DmsN0r0HLbxEEuWBH7D6Kev9dJnq+ucr+AA5K8nIVt
         KO/ruGy4Uf51WdBtv+Eln27E9m4F/DLgq5wD2U0LAu3yOpbrMUGE19O15U1olv+oUh
         tOhUBPnsLlRxcua13S5AjXCN4v31uhzky5r6RXTRl0KQsGEz8WIJQa3ehFrtzqAslE
         dz69XNAQ35LlQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5F5E338C0;
        Thu, 29 Nov 2018 04:55:13 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Nov 2018 04:55:13 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 29 Nov 2018 13:55:11 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     Jose Abreu <jose.abreu@synopsys.com>
CC:     Vitor Soares <vitor.soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+EKJZ77V6pHnEeowo0MFqE/DaVmpP6A
Date:   Thu, 29 Nov 2018 12:55:10 +0000
Message-ID: <09e6afb585a62b23e33297b1c0979703ca9fab8c.camel@synopsys.com>
References: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
In-Reply-To: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F300D3F1C3BFE4AB083D694B1E7C1EF@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zZSwNCg0KT24gVGh1LCAyMDE4LTExLTI5IGF0IDEyOjQyICswMDAwLCBKb3NlIEFicmV1
IHdyb3RlOg0KPiBTb21lIEFSQyBDUFUncyBkbyBub3Qgc3VwcG9ydCB1bmFsaWduZWQgbG9hZHMv
c3RvcmVzLiBDdXJyZW50bHksIGdlbmVyaWMNCj4gaW1wbGVtZW50YXRpb24gb2YgcmVhZHN7Yi93
L2x9KCkvd3JpdGVze2Ivdy9sfSgpIGlzIGJlaW5nIHVzZWQgd2l0aCBBUkMuDQo+IFRoaXMgY2Fu
IGxlYWQgdG8gbWlzZnVuY3Rpb24gb2Ygc29tZSBkcml2ZXJzIGFzIGdlbmVyaWMgZnVuY3Rpb25z
IGRvIGENCj4gcGxhaW4gZGVyZWZlcmVuY2Ugb2YgYSBwb2ludGVyIHRoYXQgY2FuIGJlIHVuYWxp
Z25lZC4NCj4gDQo+IExldCdzIHVzZSB7Z2V0L3B1dH1fdW5hbGlnbmVkKCkgaGVscGVyIGluc3Rl
YWQgb2YgcGxhaW4gZGVyZWZlcmVuY2Ugb2YNCj4gcG9pbnRlciBpbiBvcmRlciB0byBmaXggdGhp
cy4NCj4gDQo+IFdlIGRvIG5vdCBpbXBsZW1lbnQgcmVhZHNxKCkvd3JpdGVzcSgpIGFzIHdlIGFz
c3VtZSB0aGF0IG9ubHkgSFMgaXMgYQ0KPiA2NCBCaXQgQ1BVIGFuZCB0aGF0IGl0IHN1cHBvcnRz
IHVuYWxpZ25lZCBsb2Fkcy9zdG9yZXMuDQoNClBscyBub3RlIHRoYXQgQVJDIEhTIGlzIHN0aWxs
IG9ubHkgMzItYml0IGNvcmUgYXQgbGVhc3QgYXMgb2YgdG9kYXkuDQoNCi1BbGV4ZXkNCg==
