Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2850C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1E20685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKNoJaYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfBVA3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:29:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37079 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBVA3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:29:02 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so425543iop.4;
        Thu, 21 Feb 2019 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SuYtNbmhst7BuCDufRYvCD89GjA2HlrWVDW3QTG5zxM=;
        b=AKNoJaYNQJr+RIZbaAGWPMz3UpceW848K6kTLP7S9HU+XMKAwDWRYE0IRLlFzwLj6q
         TTq1cRPSwpeSN+UaE5z5V7fTzLvzPbUdNK/DKaZhgFspQgRMYc1lj4iMb30UfIkLdwQm
         2WKeIXvo2ErAfjOzN1T/5ZFMt9zG6QkyD6NKtG26anKEpEtjlNYT8AZHmK3xYASsz1n0
         cN4W2yP7UxgDjiEH2BclpNJt0VBFtME3HDvPXq3eTvxlbRA6+KDdK6TbWAodBeeQETNx
         v6QCJWL3bodlPWkoAz7pxTUjIFD9rQVFHvydufGBw29iojxW/1nwc+JqFy/3hVQHa4CK
         83KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SuYtNbmhst7BuCDufRYvCD89GjA2HlrWVDW3QTG5zxM=;
        b=KFJGLq1Nwj8tEbOns3B+pu2mk1g/fhoy0ZxlA+Xpe3BLKkoSXrpV7s3dRwoWRvZR9t
         IwO09HqQfVZvH8Jm2X+jkh+lAoOLbsJu82hkskU3PC6Q9Nda8q+DjitJAmFp3HXfFcY8
         Dm/tn/CcgSar9nHP3/X7qG3ARPgHyEEEpH7zQbfxbQgk7hxaoTGa6/FyQGj2xoNmmw/L
         voBym5AXVCUsRcO/GH+fHKw6gr7ePrkEizVDMJUtgVQI1pYUGBuyWSLfUqGhlblnS1cZ
         wKWBp2OuVq7tsNElicCtctBweGHG2F1oLkWbOV2wELU6zdNDWFg/6IVfZwiPgiWTAIii
         yRGQ==
X-Gm-Message-State: AHQUAubvQxJIVF0Vs2C2AQThUUTMZZqnnin0eV4Br6W1tABDDkSiewZK
        VRfa/4gP3VK5w5a7nd8/QIzSKZdR6sV+/N8Zw0Q=
X-Google-Smtp-Source: AHgI3IbpjT+rhaxj6Xc3lyUN0D7De0XaZk8CknURKJZ65XI2RQ/+pf33AkoPVafqcHGsRvfBJ54nekdISiunojrVOWw=
X-Received: by 2002:a5d:8049:: with SMTP id b9mr833328ior.302.1550795341066;
 Thu, 21 Feb 2019 16:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
In-Reply-To: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 22 Feb 2019 09:28:35 +0900
Message-ID: <CAEjAshoebQ4=u+9Y9ejMstZopOC1i5LmGTZZBjLHS74Zh_zQkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: translations: sync translations 'remove info
 about -git patches'
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-kernel@zh-kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IFNlb25nSmFlIFBhcmsgPHNqMzgucGFya0BnbWFpbC5jb20+DQoNCk9uIEZyaSwg
RmViIDIyLCAyMDE5IGF0IDU6MzAgQU0gRmVkZXJpY28gVmFnYSA8ZmVkZXJpY28udmFnYUB2YWdh
LnB2Lml0PiB3cm90ZToNCj4NCj4gU3luY2hvbmlzZSB0cmFuc2xhdGlvbnM6IENOLCBJVCwgSlAs
IEtSDQo+DQo+IGNvbW1pdCAyYzcxZDMwNWNhZjkgKCJkb2NzOiBwcm9jZXNzOiBSZW1vdmUgb3V0
ZGF0ZWQgaW5mbyBhYm91dCAtZ2l0IHBhdGNoZXMiKQ0KPg0KPiBJIGNhbiBndWFyYW50ZWUgZm9y
IHRoZSBJdGFsaWFuIHRyYW5zbGF0aW9ucywgYnV0IHNpbmNlIHdlIGFyZSByZW1vdmluZw0KPiBh
biBlbnRpcmUgY2hhcHRlciBJIHRoaW5rIEkgZGlkIGl0IHJpZ2h0IGFsc28gZm9yIHRoZSBvdGhl
ciBsYW5ndWFnZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVyaWNvIFZhZ2EgPGZlZGVyaWNv
LnZhZ2FAdmFnYS5wdi5pdD4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9p
dF9JVC9wcm9jZXNzL2hvd3RvLnJzdCB8IDEwIC0tLS0tLS0tLS0NCj4gIERvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdCAgICAgICAgIHwgIDkgLS0tLS0tLS0tDQo+ICBE
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9ob3d0by5yc3QgICAgICAgICB8ICA4IC0t
LS0tLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9IT1dUTyAgICAgICAg
ICAgICB8ICA4IC0tLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM1IGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvaXRfSVQvcHJvY2Vz
cy9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL2hv
d3RvLnJzdA0KPiBpbmRleCBmOWE0NGIxYWY4OWQuLjE1MTk5YWE1YjRkZiAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvaXRfSVQvcHJvY2Vzcy9ob3d0by5yc3QNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvaXRfSVQvcHJvY2Vzcy9ob3d0by5yc3QN
Cj4gQEAgLTMxMywxNiArMzEzLDYgQEAgSWwgZmlsZSBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3Rh
YmxlLWtlcm5lbC1ydWxlcy5yc3QgKG5laSBzb3JnZW50aSkgZG9jdW1lbnRhDQo+ICBxdWFsaSB0
aXBvbG9naWUgZGkgbW9kaWZpY2hlIHNvbm8gYWNjZXR0YXRlIHBlciBpIHNvcmdlbnRpIC1zdGFi
bGUsIGUgY29tZQ0KPiAgYXZ2aWVuZSBpbCBwcm9jZXNzbyBkaSByaWxhc2Npby4NCj4NCj4gLUxl
IG1vZGlmaWNoZSBpbiA0LnggLWdpdA0KPiAtfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC0N
Cj4gLVF1ZXN0ZSBzb25vIGlzdGFudGFuZWUgcXVvdGlkaWFuZSBkZWwga2VybmVsIGRpIExpbnVz
IGUgc29ubyBnZXN0aXRlIGluDQo+IC11bmEgcmVwb3NpdG9yaW8gZ2l0IChkYSBxdWkgaWwgbm9t
ZSkuIFF1ZXN0ZSBtb2RpZmljaGUgc29ubyBzb2xpdGFtZW50ZQ0KPiAtcmlsYXNjaWF0ZSBnaW9y
bmFsbWVudGUgZSByYXBwcmVzZW50YW5vIGwnYXR0dWFsZSBzdGF0byBkZWkgc29yZ2VudGkgZGkN
Cj4gLUxpbnVzLiBRdWVzdGUgc29ubyBkYSBjb25zaWRlcmFyc2kgcGnDuSBzcGVyaW1lbnRhbGkg
ZGkgdW4gLXJjIGluIHF1YW50bw0KPiAtZ2VuZXJhdGUgYXV0b21hdGljYW1lbnRlIHNlbnphIG5l
bW1lbm8gYXZlciBkYXRvIHVuYSByYXBpZGEgb2NjaGlhdGENCj4gLXBlciB2ZXJpZmljYXJuZSBs
byBzdGF0by4NCj4gLQ0KPg0KPiAgU29yZ2VudGkgZGVpIHNvdHRvc2lzdGVtaSBkZWwga2VybmVs
IGUgbGUgbG9ybyBwYXRjaA0KPiAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvamFfSlAvaG93dG8ucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93
dG8ucnN0DQo+IGluZGV4IDJjYTkzODlkNTkxNS4uNGZiZjQwNTUyNzI4IDEwMDY0NA0KPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gKysrIGIvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+IEBAIC0zMTksMTUgKzMx
OSw2IEBAIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLnJzdCDjg5Xj
gqHjgqTjg6vjgavjga/jganjga7jgojjgYbjgaoNCj4gIOmhnuOBruWkieabtOOBjCAtc3RhYmxl
IOODhOODquODvOOBq+WPl+OBkeWFpeOCjOWPr+iDveOBi+OAgeOBvuOBn+ODquODquODvOOCueOD
l+ODreOCu+OCueOBjOOBqeOBhg0KPiAg5YuV44GP44GL44GM6KiY6L+w44GV44KM44Gm44GE44G+
44GZ44CCDQo+DQo+IC00LnggLWdpdCDjg5Hjg4Pjg4ENCj4gLX5+fn5+fn5+fn5+fn5+fg0KPiAt
DQo+IC1naXQg44Oq44Od44K444OI44Oq44Gn566h55CG44GV44KM44Gm44GE44KLTGludXMg44Gu
44Kr44O844ON44Or44OE44Oq44O844Gu5q+O5pel44Gu44K544OK44OD44OXDQo+IC3jgrfjg6fj
g4Pjg4jjgYzjgYLjgorjgb7jgZnjgIIo44Gg44GL44KJIC1naXQg44Go44GE44GG5ZCN5YmN44GM
44Gk44GE44Gm44GE44G+44GZKeOAguOBk+OCjOOCieOBruODkeODgw0KPiAt44OB44Gv44GK44GK
44KA44Gt5q+O5pel44Oq44Oq44O844K544GV44KM44Gm44GK44KK44CBTGludXMg44Gu44OE44Oq
44O844Gu54++54q244KS6KGo44GX44G+44GZ44CC44GTDQo+IC3jgozjga8gLXJjIOOCq+ODvOOD
jeODq+OBqOavlOOBueOBpuOAgeODkeODg+ODgeOBjOWkp+S4iOWkq+OBi+OBqeOBhuOBi+OCguei
uuiqjeOBl+OBquOBhOOBp+iHquWLleeahA0KPiAt44Gr55Sf5oiQ44GV44KM44KL44Gu44Gn44CB
44KI44KK5a6f6aiT55qE44Gn44GZ44CCDQo+IC0NCj4gIOOCteODluOCt+OCueODhuODoOavjuOB
ruOCq+ODvOODjeODq+ODhOODquODvOOBqOODkeODg+ODgQ0KPiAgfn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL2tvX0tSL2hvd3RvLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tv
X0tSL2hvd3RvLnJzdA0KPiBpbmRleCA1Mjg0MzM5MzI1ODkuLmQ4YWNmMjU1YWM1ZiAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvaG93dG8ucnN0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hvd3RvLnJzdA0KPiBAQCAtMzAy
LDE0ICszMDIsNiBAQCBBbmRyZXcgTW9ydG9u7J2YIOq4gOydtCDsnojri6QuDQo+ICDtjIzsnbzs
nYAg7Ja065akIOyiheulmOydmCDrs4Dqsr3rk6TsnbQgLXN0YWJsZSDtirjrpqzroZwg65Ok7Ja0
7JmU64qU7KeA7JmADQo+ICDrsLDtj6wg7ZSE66Gc7IS47Iqk6rCAIOyWtOuWu+qyjCDsp4Ttlonr
kJjripTsp4Drpbwg7ISk66qF7ZWc64ukLg0KPg0KPiAtNC54IC1naXQg7Yyo7LmY65OkDQo+IC1+
fn5+fn5+fn5+fn5+fn4NCj4gLQ0KPiAtZ2l0IOyggOyepeyGjCjqt7jrn6zrr4DroZwgLWdpdOyd
tOudvOuKlCDsnbTrpoTsnbQg67aZ7J2MKeyXkOuKlCDrgqDrp4jri6Qg6rSA66as65CY64qUIExp
bnVz7J2YDQo+IC3su6TrhJAg7Yq466as7J2YIHNuYXBzaG90IOuTpOydtCDsnojri6QuIOydtCDt
jKjsuZjrk6TsnYAg7J2867CY7KCB7Jy866GcIOuCoOuniOuLpCDrsLDtj6zrkJjrqbANCj4gLUxp
bnVz7J2YIO2KuOumrOydmCDtmITsnqwg7IOB7YOc66W8IOuCmO2DgOuCuOuLpC4g7J20IO2MqOy5
mOuTpOydgCDsoJXsg4HsoIHsnbjsp4Ag7KGw6riI64+EDQo+IC3sgrTtjrTrs7Tsp4Ag7JWK6rOg
IOyekOuPmeyggeycvOuhnCDsg53shLHrkJwg6rKD7J2066+A66GcIC1yYyDsu6TrhJDrk6Qg67O0
64uk64+EIOuNlCDsi6Ttl5jsoIHsnbTri6QuDQo+IC0NCj4gIOyEnOu4jOyLnOyKpO2FnCDsu6Tr
hJAg7Yq466as65Ok6rO8IO2MqOy5mOuTpA0KPiAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
SE9XVE8gYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9IT1dUTw0KPiBpbmRleCA1
ZjZkMDllZGM5YWMuLjhlN2RlZTgwYTA4NyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vSE9XVE8NCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vSE9XVE8NCj4gQEAgLTI0MCwxNCArMjQwLDYgQEAga2VybmVsLm9yZ+e9keermeea
hHB1Yi9saW51eC9rZXJuZWwvdjIuNi/nm67lvZXkuIvmib7liLDlroPjgILlroPnmoTlvIDlj5Hp
gbXlvqoNCj4gIOeJiOWGheaguOaOpeWPl+eahOS/ruaUueexu+Wei+S7peWPiuWPkeW4g+eahOa1
geeoi+OAgg0KPg0KPg0KPiAtMi42LnggLWdpdOihpeS4gembhg0KPiAtLS0tLS0tLS0tLS0tLS0t
LQ0KPiAtTGludXPnmoTlhoXmoLjmupDnoIHmoJHnmoTmr4/ml6Xlv6vnhafvvIzov5nkuKrmupDn
oIHmoJHmmK/nlLFnaXTlt6XlhbfnrqHnkIbnmoTvvIjnlLHmraTlvpflkI3vvInjgILov5kNCj4g
LeS6m+ihpeS4gemAmuW4uOavj+WkqeabtOaWsOS7peWPjeaYoExpbnVz55qE5rqQ56CB5qCR55qE
5pyA5paw54q25oCB44CC5a6D5Lus5q+ULXJj54mI5pys55qE5YaF5qC45rqQ56CBDQo+IC3moJHm
m7Tlhbfor5XpqozmgKfotKjvvIzlm6DkuLrov5nkuKrooaXkuIHpm4bmmK/lhajoh6rliqjnlJ/m
iJDnmoTvvIzmsqHmnInku7vkvZXkurrmnaXnoa7orqTlhbbmmK/lkKbnnJ/mraMNCj4gLeWBpeWF
qOOAgg0KPiAtDQo+IC0NCj4gIDIuNi54IC1tbeihpeS4gembhg0KPiAgLS0tLS0tLS0tLS0tLS0t
DQo+ICDov5nmmK/nlLFBbmRyZXcgTW9ydG9u57u05oqk55qE6K+V6aqM5oCn5YaF5qC46KGl5LiB
6ZuG44CCQW5kcmV35bCG5omA5pyJ5a2Q57O757uf55qE5YaF5qC45rqQ56CBDQo+IC0tDQo+IDIu
MjAuMQ0KPg0K
