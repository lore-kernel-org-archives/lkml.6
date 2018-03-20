Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCTWTH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:19:07 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:44603 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbeCTWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:19:04 -0400
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: detecting integer constant expressions in macros
Thread-Topic: detecting integer constant expressions in macros
Thread-Index: AQHTwJiwGR/EgJUmakKV29wYTwhXcQ==
Date: Tue, 20 Mar 2018 22:13:35 +0000
Message-ID: <1521584015.31174.3.camel@med.uni-goettingen.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <458DAE36413F474585B2D9F34FD1FEE3@ads.local.med.uni-goettingen.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KMJA9H009358


Hi Linus,

here is an idea:

a test for integer constant expressions which returns an
integer constant expression itself which should be suitable
for passing to __builtin_choose_expr might be:

#define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((x) * 0l)) :
(int*)1)))

This also does not evaluate x itself on gcc although this is
not guaranteed by the standard. (And I haven't tried any older
gcc.)

Best,
Martin
