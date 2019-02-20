Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C92C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39508214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3TL+FU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfBTXXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:23:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39817 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:23:33 -0500
Received: by mail-it1-f196.google.com with SMTP id l15so19998050iti.4;
        Wed, 20 Feb 2019 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DYCCOUdmJfBSqBJWu4VKd8SRT8ydKJr76upnoyo2v0A=;
        b=J3TL+FU5FkjkOfmbWh3735iLy4Ms5TXCw370Sz1xhnonkT+wPpKr5hIWnsqjKQTlk1
         ZNCQ+3iiop5BwZckqTvwB/H0VRfI2u5kmcT3qJoW9Zhd1X7aQa2BStWc+rCnBWzYiiAu
         WLVluWKRnNwoXaDcaNv8Rq9rzhckrisBymWKqX1U+CvYeintZDh/krEnh9xIisu/upMw
         0GSyzQ1+ZhDrE7BIJDZTzEN0deMqrUB+OkrF0W1fOhuyHfyToSPg6+9ZF3Xh1HRmWNnU
         MHrXs/pPRs2gJI8GERF3dFdVLOdt6DgBXSujggKrNThqjFIDhGhGmhIRlfi6vNeRvSp9
         QrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DYCCOUdmJfBSqBJWu4VKd8SRT8ydKJr76upnoyo2v0A=;
        b=dIQXd6hEkeBRklkPaVu5qLCtaC1wFGk2PwM3og9+aXqHPtk68Yg5b9tWx3jwwlgptq
         nsWhU1gKTQDyP+xCKbR2JgNQHadCyaYKOxOOs2dVZ7ueyuOG044ls4+akS9aJ52ET+Z+
         E0oqoDDMrxEvDimzOEDkmjfJtoU0hps4n13FWLD1OeuRcS1NYZOUoI8oXWDlXtdVVRHZ
         bQUvk+DlDULFsSGoQglNTE8SZEZZTzqE6aDzbRPRjoU+IHea5rhnbdO32U4zRjY9XqEN
         5o3CBnQQI7EQzwSYRavZQ4suGwsSrLE1OUmhmcyoAyNKDBs6ZDNzVNUy5GYi2M1yNxyt
         raiA==
X-Gm-Message-State: AHQUAubMSmGZ0dy0KBjl3vYc5WdMoytaNsvI3+qSWMgqsvbq+3SJWvry
        MfmB6swxZv488FzLRPXd8b8ru7ltkSXhsMDfqKk=
X-Google-Smtp-Source: AHgI3IbsvZyXEq/twP1yMlBg91pxHUjDLBIkR6vNRissmrLEY1nxMFRnI5T/Yhczn5AMXOshFPFkugcIHMSm9Fuwa3M=
X-Received: by 2002:a02:5546:: with SMTP id e67mr20697484jab.10.1550705011619;
 Wed, 20 Feb 2019 15:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20190220230305.20123-1-federico.vaga@vaga.pv.it>
In-Reply-To: <20190220230305.20123-1-federico.vaga@vaga.pv.it>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Thu, 21 Feb 2019 08:23:04 +0900
Message-ID: <CAEjAshpnWuhWVOARVfsoGaiuUQ1hQtYRrbq-3DJciRJErQDUvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: translations: sync translations 'remove info
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

SGVsbG8sDQoNCk9uIFRodSwgRmViIDIxLCAyMDE5IGF0IDg6MDMgQU0gRmVkZXJpY28gVmFnYSA8
ZmVkZXJpY28udmFnYUB2YWdhLnB2Lml0PiB3cm90ZToNCj4NCj4gU3luY2hvbmlzZSB0cmFuc2xh
dGlvbnM6IENOLCBJVCwgSlAsIEtSDQo+DQo+IGNvbW1pdCAyYzcxZDMwNWNhZjkgKCJkb2NzOiBw
cm9jZXNzOiBSZW1vdmUgb3V0ZGF0ZWQgaW5mbyBhYm91dCAtZ2l0IHBhdGNoZXMiKQ0KPg0KPiBJ
IGNhbiBndWFyYW50ZWUgZm9yIHRoZSBJdGFsaWFuIHRyYW5zbGF0aW9ucywgYnV0IHNpbmNlIHdl
IGFyZSByZW1vdmluZw0KPiBhbiBlbnRpcmUgY2hhcHRlciBJIHRoaW5rIEkgZGlkIGl0IHJpZ2h0
IGFsc28gZm9yIHRoZSBvdGhlciBsYW5ndWFnZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVy
aWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAdmFnYS5wdi5pdD4NCj4gLS0tDQo+ICBEb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL2hvd3RvLnJzdCB8IDEwIC0tLS0tLS0tLS0N
Cj4gIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdCAgICAgICAgIHwg
IDggLS0tLS0tLS0NCj4gIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hvd3RvLnJz
dCAgICAgICAgIHwgIDcgLS0tLS0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vSE9XVE8gICAgICAgICAgICAgfCAgOCAtLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAz
MyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL2l0X0lUL3Byb2Nlc3MvaG93dG8ucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
aXRfSVQvcHJvY2Vzcy9ob3d0by5yc3QNCj4gaW5kZXggZjlhNDRiMWFmODlkLi4xNTE5OWFhNWI0
ZGYgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2l0X0lUL3Byb2Nl
c3MvaG93dG8ucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2l0X0lUL3By
b2Nlc3MvaG93dG8ucnN0DQo+IEBAIC0zMTMsMTYgKzMxMyw2IEBAIElsIGZpbGUgRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMucnN0IChuZWkgc29yZ2VudGkpIGRvY3Vt
ZW50YQ0KPiAgcXVhbGkgdGlwb2xvZ2llIGRpIG1vZGlmaWNoZSBzb25vIGFjY2V0dGF0ZSBwZXIg
aSBzb3JnZW50aSAtc3RhYmxlLCBlIGNvbWUNCj4gIGF2dmllbmUgaWwgcHJvY2Vzc28gZGkgcmls
YXNjaW8uDQo+DQo+IC1MZSBtb2RpZmljaGUgaW4gNC54IC1naXQNCj4gLX5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPiAtDQo+IC1RdWVzdGUgc29ubyBpc3RhbnRhbmVlIHF1b3RpZGlhbmUgZGVs
IGtlcm5lbCBkaSBMaW51cyBlIHNvbm8gZ2VzdGl0ZSBpbg0KPiAtdW5hIHJlcG9zaXRvcmlvIGdp
dCAoZGEgcXVpIGlsIG5vbWUpLiBRdWVzdGUgbW9kaWZpY2hlIHNvbm8gc29saXRhbWVudGUNCj4g
LXJpbGFzY2lhdGUgZ2lvcm5hbG1lbnRlIGUgcmFwcHJlc2VudGFubyBsJ2F0dHVhbGUgc3RhdG8g
ZGVpIHNvcmdlbnRpIGRpDQo+IC1MaW51cy4gUXVlc3RlIHNvbm8gZGEgY29uc2lkZXJhcnNpIHBp
w7kgc3BlcmltZW50YWxpIGRpIHVuIC1yYyBpbiBxdWFudG8NCj4gLWdlbmVyYXRlIGF1dG9tYXRp
Y2FtZW50ZSBzZW56YSBuZW1tZW5vIGF2ZXIgZGF0byB1bmEgcmFwaWRhIG9jY2hpYXRhDQo+IC1w
ZXIgdmVyaWZpY2FybmUgbG8gc3RhdG8uDQo+IC0NCj4NCj4gIFNvcmdlbnRpIGRlaSBzb3R0b3Np
c3RlbWkgZGVsIGtlcm5lbCBlIGxlIGxvcm8gcGF0Y2gNCj4gIH5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL2phX0pQL2hvd3RvLnJzdA0KPiBpbmRleCAyY2E5Mzg5ZDU5MTUuLjhkZTQxYTZjZTk4
NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8u
cnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdA0K
PiBAQCAtMzE5LDE0ICszMTksNiBAQCBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWtlcm5l
bC1ydWxlcy5yc3Qg44OV44Kh44Kk44Or44Gr44Gv44Gp44Gu44KI44GG44GqDQo+ICDpoZ7jga7l
pInmm7TjgYwgLXN0YWJsZSDjg4Tjg6rjg7zjgavlj5fjgZHlhaXjgozlj6/og73jgYvjgIHjgb7j
gZ/jg6rjg6rjg7zjgrnjg5fjg63jgrvjgrnjgYzjganjgYYNCj4gIOWLleOBj+OBi+OBjOiomOi/
sOOBleOCjOOBpuOBhOOBvuOBmeOAgg0KPg0KPiAtNC54IC1naXQg44OR44OD44OBDQo+IC1+fn5+
fn5+fn5+fn5+fn4NCj4gLQ0KPiAtZ2l0IOODquODneOCuOODiOODquOBp+euoeeQhuOBleOCjOOB
puOBhOOCi0xpbnVzIOOBruOCq+ODvOODjeODq+ODhOODquODvOOBruavjuaXpeOBruOCueODiuOD
g+ODlw0KPiAt44K344On44OD44OI44GM44GC44KK44G+44GZ44CCKOOBoOOBi+OCiSAtZ2l0IOOB
qOOBhOOBhuWQjeWJjeOBjOOBpOOBhOOBpuOBhOOBvuOBmSnjgILjgZPjgozjgonjga7jg5Hjg4MN
Cj4gLeODgeOBr+OBiuOBiuOCgOOBreavjuaXpeODquODquODvOOCueOBleOCjOOBpuOBiuOCiuOA
gUxpbnVzIOOBruODhOODquODvOOBruePvueKtuOCkuihqOOBl+OBvuOBmeOAguOBkw0KPiAt44KM
44GvIC1yYyDjgqvjg7zjg43jg6vjgajmr5TjgbnjgabjgIHjg5Hjg4Pjg4HjgYzlpKfkuIjlpKvj
gYvjganjgYbjgYvjgoLnorroqo3jgZfjgarjgYTjgafoh6rli5XnmoQNCj4gLeOBq+eUn+aIkOOB
leOCjOOCi+OBruOBp+OAgeOCiOOCiuWun+mok+eahOOBp+OBmeOAgg0KPg0KPiAg44K144OW44K3
44K544OG44Og5q+O44Gu44Kr44O844ON44Or44OE44Oq44O844Go44OR44OD44OBDQo+ICB+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvaG93dG8ucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMva29fS1IvaG93dG8ucnN0DQo+IGluZGV4IDUyODQzMzkzMjU4OS4uZDhmYzdjMzFi
ZGU5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9ob3d0
by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvaG93dG8ucnN0
DQo+IEBAIC0zMDIsMTMgKzMwMiw2IEBAIEFuZHJldyBNb3J0b27snZgg6riA7J20IOyeiOuLpC4N
Cj4gIO2MjOydvOydgCDslrTrlqQg7KKF66WY7J2YIOuzgOqyveuTpOydtCAtc3RhYmxlIO2KuOum
rOuhnCDrk6TslrTsmZTripTsp4DsmYANCj4gIOuwsO2PrCDtlITroZzshLjsiqTqsIAg7Ja065a7
6rKMIOynhO2WieuQmOuKlOyngOulvCDshKTrqoXtlZzri6QuDQo+DQo+IC00LnggLWdpdCDtjKjs
uZjrk6QNCj4gLX5+fn5+fn5+fn5+fn5+fg0KPiAtDQo+IC1naXQg7KCA7J6l7IaMKOq3uOufrOuv
gOuhnCAtZ2l07J20652864qUIOydtOumhOydtCDrtpnsnYwp7JeQ64qUIOuCoOuniOuLpCDqtIDr
pqzrkJjripQgTGludXPsnZgNCj4gLey7pOuEkCDtirjrpqzsnZggc25hcHNob3Qg65Ok7J20IOye
iOuLpC4g7J20IO2MqOy5mOuTpOydgCDsnbzrsJjsoIHsnLzroZwg64Kg66eI64ukIOuwsO2PrOuQ
mOupsA0KPiAtTGludXPsnZgg7Yq466as7J2YIO2YhOyerCDsg4Htg5zrpbwg64KY7YOA64K464uk
LiDsnbQg7Yyo7LmY65Ok7J2AIOygleyDgeyggeyduOyngCDsobDquIjrj4QNCj4gLeyCtO2OtOuz
tOyngCDslYrqs6Ag7J6Q64+Z7KCB7Jy866GcIOyDneyEseuQnCDqsoPsnbTrr4DroZwgLXJjIOy7
pOuEkOuTpCDrs7Tri6Trj4Qg642UIOyLpO2XmOyggeydtOuLpC4NCg0KSXQgd291bGQgYmUgYmV0
dGVyIHRvIGRlbGV0ZSBvbmUgbW9yZSBibGFuayBsaW5lIGZvciBjb25zaXN0ZW50IHNwYWNlcyBi
ZXR3ZWVuDQpzZWN0aW9ucy4NCg0KDQpUaGFua3MsDQpTZW9uZ0phZSBQYXJrDQoNCj4NCj4gIOyE
nOu4jOyLnOyKpO2FnCDsu6TrhJAg7Yq466as65Ok6rO8IO2MqOy5mOuTpA0KPiAgfn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vSE9XVE8gYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9I
T1dUTw0KPiBpbmRleCA1ZjZkMDllZGM5YWMuLjhlN2RlZTgwYTA4NyAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vSE9XVE8NCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vSE9XVE8NCj4gQEAgLTI0MCwxNCArMjQwLDYgQEAga2Vy
bmVsLm9yZ+e9keermeeahHB1Yi9saW51eC9rZXJuZWwvdjIuNi/nm67lvZXkuIvmib7liLDlroPj
gILlroPnmoTlvIDlj5HpgbXlvqoNCj4gIOeJiOWGheaguOaOpeWPl+eahOS/ruaUueexu+Wei+S7
peWPiuWPkeW4g+eahOa1geeoi+OAgg0KPg0KPg0KPiAtMi42LnggLWdpdOihpeS4gembhg0KPiAt
LS0tLS0tLS0tLS0tLS0tLQ0KPiAtTGludXPnmoTlhoXmoLjmupDnoIHmoJHnmoTmr4/ml6Xlv6vn
hafvvIzov5nkuKrmupDnoIHmoJHmmK/nlLFnaXTlt6XlhbfnrqHnkIbnmoTvvIjnlLHmraTlvpfl
kI3vvInjgILov5kNCj4gLeS6m+ihpeS4gemAmuW4uOavj+WkqeabtOaWsOS7peWPjeaYoExpbnVz
55qE5rqQ56CB5qCR55qE5pyA5paw54q25oCB44CC5a6D5Lus5q+ULXJj54mI5pys55qE5YaF5qC4
5rqQ56CBDQo+IC3moJHmm7Tlhbfor5XpqozmgKfotKjvvIzlm6DkuLrov5nkuKrooaXkuIHpm4bm
mK/lhajoh6rliqjnlJ/miJDnmoTvvIzmsqHmnInku7vkvZXkurrmnaXnoa7orqTlhbbmmK/lkKbn
nJ/mraMNCj4gLeWBpeWFqOOAgg0KPiAtDQo+IC0NCj4gIDIuNi54IC1tbeihpeS4gembhg0KPiAg
LS0tLS0tLS0tLS0tLS0tDQo+ICDov5nmmK/nlLFBbmRyZXcgTW9ydG9u57u05oqk55qE6K+V6aqM
5oCn5YaF5qC46KGl5LiB6ZuG44CCQW5kcmV35bCG5omA5pyJ5a2Q57O757uf55qE5YaF5qC45rqQ
56CBDQo+IC0tDQo+IDIuMjAuMQ0KPg0K
