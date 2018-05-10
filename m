Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966579AbeEJQiy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:38:54 -0400
Received: from smtp-out6.electric.net ([192.162.217.182]:55774 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:38:53 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86: pad assembly functions with INT3
Thread-Topic: [PATCH] x86: pad assembly functions with INT3
Thread-Index: AQHT5kvUTXOpwgS8vUa+aOfUWAYmp6QpLZRA
Date: Thu, 10 May 2018 16:39:55 +0000
Message-ID: <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com>
References: <20180507213755.GA32406@avx2>
In-Reply-To: <20180507213755.GA32406@avx2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AGd000014437

From: Alexey Dobriyan
> Sent: 07 May 2018 22:38
> 
> Use INT3 instead of NOP. All that padding between functions is
> an illegal area, no legitimate code should jump into it.
> 
> I've checked x86_64 allyesconfig disassembly, all changes looks sane:
> INT3 is only used after RET or unconditional JMP.

I thought there was a performance penalty (on at least some cpu)
depending on the number of and the actual instructions used for padding.

I believe that is why gcc generates a small number of very long 'nop'
instructions when padding code.

	David
