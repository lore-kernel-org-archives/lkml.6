Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 234C5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D659B208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D659B208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935515AbeFMSN0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:13:26 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:37545 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935445AbeFMSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:13:24 -0400
Received: by mail-io0-f200.google.com with SMTP id g20-v6so2839913ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=M/YQN7wccjyS9CfIXdd3u3Fwrn79BcvVOuFlGXMH5DY=;
        b=FB9V5VtEeWLfrqMduz4hjpuMuNTjimx8zvyo8eOG5J32skuR0Gs8zEGmtDb0qB2yFv
         6Yf4FSGy/mwQ3yJOqYXUraniX3aDPolVzwUGsiYjWWmOtS7etLvXHRNqqFPiABkh5fY3
         T+e2GAwxit3LLyumV25gOIB/OWQoMSS4P2/FNoF4hdn4VYVgXXn8T1rVHIxbbyfl9Yz4
         RAVG+ZTtDhvVQIgGKdwpUc9txmVsKMl24QXdC1k76cUWYQmYk2aqPv2kPELQcfoAfwWs
         iQj1IKxp2+9j+1OL1SimAKeIOD6PMCMSc7RpFuS/iUyJTg+AafdtMSgBVFsM3icwbCHX
         imSQ==
X-Gm-Message-State: APt69E02l1ANL/PP2+w6kCT1V6nbr235SeMhW8AnA1sE5QrWncr5smvW
        3rpLFbGp8NO/j9+WBDyP3dFL1KrKJ86C2FZPPpWHjvZNOzRQ
X-Google-Smtp-Source: ADUXVKJtKBOc+HbwLr/hp1JZP780bsMz+ZW/qHqjDoCjdluZgvOstEyx7xPx8wpEZu1krTQGCL7tR7a+g0wYWR3Y/0iiAwCtIpUM
MIME-Version: 1.0
X-Received: by 2002:a24:455c:: with SMTP id y89-v6mr2604626ita.0.1528913603861;
 Wed, 13 Jun 2018 11:13:23 -0700 (PDT)
Date:   Wed, 13 Jun 2018 11:13:23 -0700
In-Reply-To: <b3af0f35-b0f8-859d-4f8f-b919d35ebaaa@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000402477056e89f067@google.com>
Subject: Re: Re: KASAN: slab-out-of-bounds Read in bpf_skb_vlan_push
From:   syzbot <syzbot+76de61614cb1abdd73fc@syzkaller.appspotmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwNi8xMy8yMDE4IDA2OjE3IFBNLCBzeXpib3Qgd3JvdGU6DQo+PiBIZWxsbywNCg0KPj4g
c3l6Ym90IGZvdW5kIHRoZSBmb2xsb3dpbmcgY3Jhc2ggb246DQoNCj4+IEhFQUQgY29tbWl0OsKg
wqDCoCA3NWQ0ZTcwNGZhOGQgbmV0ZGV2LUZBUTogY2xhcmlmeSBEYXZlTSdzIHBvc2l0aW9uIGZv
ciAgDQo+PiBzdGFiLi4NCj4+IGdpdCB0cmVlOsKgwqDCoMKgwqDCoCBicGYtbmV4dA0KPj4gY29u
c29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTE3
NTQ3ODNmODAwMDAwDQo+PiBrZXJuZWwgY29uZmlnOsKgICANCj4+IGh0dHBzOi8vc3l6a2FsbGVy
LmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWE2MDFhODBmZWM0NjFkNDQNCj4+IGRhc2hib2FyZCBs
aW5rOiAgDQo+PiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NzZkZTYx
NjE0Y2IxYWJkZDczZmMNCj4+IGNvbXBpbGVyOsKgwqDCoMKgwqDCoCBnY2MgKEdDQykgOC4wLjEg
MjAxODA0MTMgKGV4cGVyaW1lbnRhbCkNCj4+IHN5emthbGxlciAgDQo+PiByZXBybzpodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTEyYzFlMWJmODAwMDAwDQoNCj4+
IElNUE9SVEFOVDogaWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcg
dGFnIHRvIHRoZSAgDQo+PiBjb21taXQ6DQo+PiBSZXBvcnRlZC1ieTogc3l6Ym90Kzc2ZGU2MTYx
NGNiMWFiZGQ3M2ZjQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCg0KPj4gSVB2NjogQUREUkNP
TkYoTkVUREVWX0NIQU5HRSk6IHZldGgxOiBsaW5rIGJlY29tZXMgcmVhZHkNCj4+IElQdjY6IEFE
RFJDT05GKE5FVERFVl9DSEFOR0UpOiB2ZXRoMDogbGluayBiZWNvbWVzIHJlYWR5DQo+PiA4MDIx
cTogYWRkaW5nIFZMQU4gMCB0byBIVyBmaWx0ZXIgb24gZGV2aWNlIHRlYW0wDQo+PiA4MDIxcTog
YWRkaW5nIFZMQU4gMCB0byBIVyBmaWx0ZXIgb24gZGV2aWNlIHRlYW0wDQo+PiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4+IEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBza2JfYXRfdGNfaW5ncmVzcyAg
DQo+PiBpbmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oOjUzNSBbaW5saW5lXQ0KPj4gQlVHOiBLQVNB
Tjogc2xhYi1vdXQtb2YtYm91bmRzIGluIGJwZl9wdXNoX21hY19yY3N1bSAgDQo+PiBuZXQvY29y
ZS9maWx0ZXIuYzoxNjI1IFtpbmxpbmVdDQo+PiBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3Vu
ZHMgaW4gX19fX2JwZl9za2Jfdmxhbl9wdXNoICANCj4+IG5ldC9jb3JlL2ZpbHRlci5jOjI0NDYg
W2lubGluZV0NCj4+IEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBicGZfc2tiX3Zs
YW5fcHVzaCsweDZiNy8weDcyMCAgDQo+PiBuZXQvY29yZS9maWx0ZXIuYzoyNDM3DQo+PiBSZWFk
IG9mIHNpemUgNSBhdCBhZGRyIGZmZmY4ODAxYjc3MzQ3ZDAgYnkgdGFzayBzeXotZXhlY3V0b3I2
LzY1MjkNCg0KPiBTaG91bGQgYmUgZml4ZWQgYWxyZWFkeSBieToNCg0KPiAgICAgDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPTU4OTkwZDFmZjNmNzg5NmVlMzQxMDMwZTlhN2MyZTQwMDI1NzA2ODMN
Cg0KDQo+ICNzeXogdGVzdDogIA0KPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQoNCndhbnQgMiBhcmdzIChyZXBvLCBicmFu
Y2gpLCBnb3QgMQ0KDQo=
