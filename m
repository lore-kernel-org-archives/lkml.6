Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeB1JF2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:05:28 -0500
Received: from smtp-out6.electric.net ([192.162.217.181]:54288 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeB1JFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:05:25 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Stefano Stabellini'" <sstabellini@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pvcalls-front: 64-bit align flags
Thread-Topic: [PATCH] pvcalls-front: 64-bit align flags
Thread-Index: AQHTsAT/Cr5qqOD/wkWB1uwC1GV/XKO5hi7g
Date: Wed, 28 Feb 2018 09:06:17 +0000
Message-ID: <139554adced44c5ea5aa4fab4f0ca8a0@AcuMS.aculab.com>
References: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260>
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

From: Stefano Stabellini
> Sent: 27 February 2018 19:55
> 
> We are using test_and_* operations on the status and flag fields of
> struct sock_mapping. However, these functions require the operand to be
> 64-bit aligned on arm64. Currently, only status is 64-bit aligned.

That sounds like a big accident just waiting to happen...
If the operand is required to be 64bit aligned why isn't it a type
that requires 64bit alignment?

> Make flags 64-bit aligned by introducing an explicit padding field.

At some point such padding will always go wrong...

	David
