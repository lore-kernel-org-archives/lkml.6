Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeCTXHd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:07:33 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:42695 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751557AbeCTXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:07:32 -0400
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: detecting integer constant expressions in macros
Thread-Topic: detecting integer constant expressions in macros
Thread-Index: AQHTwJiwGR/EgJUmakKV29wYTwhXcaPZrniA
Date: Tue, 20 Mar 2018 23:07:28 +0000
Message-ID: <1521587247.32102.1.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
In-Reply-To: <1521584015.31174.3.camel@med.uni-goettingen.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA4D806C74A50544923112D0DFE835A9@ads.local.med.uni-goettingen.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KN7d0g015462



talking of crazy ideas, here is another way to preserve
integer const expressions in macros by storing it a
VLA type (only for positive integers I guess):


#define MAX(a, b) sizeof(*({    \
        typedef char _Ta[a];    \
        typedef char _Tb[b];    \
        (char(*)[sizeof(_Ta) > sizeof(_Tb) ? sizeof(_Ta) :
sizeof(_Tb)])0; }))

Am Dienstag, den 20.03.2018, 23:13 +0100 schrieb Martin Uecker:
> Hi Linus,
> 
> here is an idea:
> 
> a test for integer constant expressions which returns an
> integer constant expression itself which should be suitable
> for passing to __builtin_choose_expr might be:
> 
> #define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((x) * 0l)) :
> (int*)1)))
> 
> This also does not evaluate x itself on gcc although this is
> not guaranteed by the standard. (And I haven't tried any older
> gcc.)
> 
> Best,
> Martin
