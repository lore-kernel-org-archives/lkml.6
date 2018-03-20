Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeCTKPy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:15:54 -0400
Received: from smtp-out6.electric.net ([192.162.217.190]:64861 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeCTKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:15:49 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Chang S. Bae'" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC: "luto@kernel.org" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "markus.t.metzger@intel.com" <markus.t.metzger@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on
 paranoid_entry
Thread-Topic: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases
 on paranoid_entry
Thread-Index: AQHTv8TePyJOGC70+0OZPg5byt68MqPY6GkQ
Date: Tue, 20 Mar 2018 10:16:36 +0000
Message-ID: <eb30911b621144fe92e77fd2d9da7efe@AcuMS.aculab.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
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

From: Chang S. Bae
> Sent: 19 March 2018 17:49
...
> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
> GS base is not the kernel's.
> 
> FSGSBASE instructions allow user to write any value on GS base;
> even negative. Sign check on the current GS base is not
> sufficient. Fortunately, reading GS base is fast. Kernel GS
> base is also known from the offset table with the CPU number.
...

Use code might want to put a negative value into GSBASE.
While it is normal to put a valid address into GSBASE there
is no reason why the code can't put an offset into GSBASE,
in which case it might be negative.

Yes, I know you can't put arbitrary 64bit values into GSBASE.
But the difference between 2 user pointers will always be valid.

	David
