Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1993284-1519751305-2-7827145690441449573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519751305; b=fjbBolyiB5IDqaIixOS0rkHnz+IOmqzaLKkliSfGa7fgFrY
    AiLN1loUioRqZWl+w4d/MTufJVkn0/ubBpgIzyLvaVK75wPbGObWnQRgBCI0jbn7
    +eNcG29++1VXXpCe+A4396cuGopclXxDUnpUUW0gEujvb8rGRNRqm4drA2nu+j4E
    wNMQKZJrKJkJfY4lBPuzriZhh1p/VQc0ypk0/f51GSYl+pYcZn3SW1Sotcl4Uvdh
    BSZg5ckWUeYVO0jcg8vms0Q3cinpu0T+siqQIfaGOv2DZeWKxioy0OKmVeooXgS/
    zJ2al9tHl+YkRN/Lkoqo2RgkroufK3YH8+gPfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:cc:references:to:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1519751305; bh=m7Q4RRaMGknVbuDxx4aYqkZYRrUGSF3N0T01ae
    dkKTE=; b=YnC5vvRGOQ8NRrS1gF2DE7hCln23/GLxQ+K4F9D6DP2hT2xBMGMiQd
    17037drCt0gCJQyoaYEq2AjJtjj/iYQEcY1zSAwYgVZKnQNTX9k3hlAQa80UA2L5
    D9DaMYEmyWQzjaYjVSJZjfyRblrSKniF+9f/iGen3n489NI2a14YSi/oMecAMPJt
    67lIoYyaP5NycxklZTeuQNQc6RQbLrvD9Fhk6l4QjbKxvdAEdI2Pz1zc9y8/etDY
    7m8+zeQSzIA5JQKfLxZ+V8s/feQTFfw0cOEObvZkNdqNQ6/Bsxt10HFaUKtJFzOq
    U/0+DNQaSuxi7KwrZMwt/5mcrL3vWxVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnCJemER x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnCJemER x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeB0RIW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:08:22 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57877 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751004AbeB0RIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 12:08:19 -0500
X-ME-Sender: <xms:gpCVWmFTe2L9to7-zBAn3u6qW7XWu8EWg6zGYTRZ_56wASWaHC5_BA>
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        xen-devel@lists.xenproject.org
References: <20180207234923.13544-1-prarit@redhat.com>
 <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
To: stable@vger.kernel.org
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <9a7c4dae-4758-5aca-b3af-2129b62719e2@invisiblethingslab.com>
Date: Tue, 27 Feb 2018 17:08:00 +0000
MIME-Version: 1.0
In-Reply-To: <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JMngEWmMcPHWStrIjEXor47fA6wpJJMRn"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JMngEWmMcPHWStrIjEXor47fA6wpJJMRn
Content-Type: multipart/mixed; boundary="2I3xzpHpxaU3zHZL2ruHtg5OjUjA6ry4H";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, xen-devel@lists.xenproject.org
Message-ID: <9a7c4dae-4758-5aca-b3af-2129b62719e2@invisiblethingslab.com>
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
References: <20180207234923.13544-1-prarit@redhat.com>
 <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
In-Reply-To: <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>

--2I3xzpHpxaU3zHZL2ruHtg5OjUjA6ry4H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Boris Ostrovsky:
> On 02/07/2018 06:49 PM, Prarit Bhargava wrote:
>> The kernel panics on PV domains because native_smp_cpus_done() is
>> only called for HVM domains.
>>
>> Calculate __max_logical_packages for PV domains.
>>
>> Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate=
")
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Cc: Prarit Bhargava <prarit@redhat.com>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Cc: xen-devel@lists.xenproject.org
>=20
>=20
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

The fixed bug is in 4.15 so it should get into stable. It's
63e708f826bb21470155d37b103a75d8a9e25b18 upstream.


--2I3xzpHpxaU3zHZL2ruHtg5OjUjA6ry4H--

--JMngEWmMcPHWStrIjEXor47fA6wpJJMRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlqVkIoACgkQkO9xfO/x
ly8mrA//VO8ImbrrDAH96dqEKxlkrZJR7d/c7BX5Wr7YYjRN/cRjCMJVTRpKAmjV
95mk8Ra4S0U2zlKV/sG02q5Ni/lgmPtOcHJ9SerVXywDaREHX+xoNc8yM/y4DWbE
uABPS8JFBhNfzCFSBqYjHeKrnPpniEdiZgl+YUZTRyx559gHU/wU0CH7II1IUvm9
SEanahC4xjPhLkSh0bfITimB+Dg6xPnG91ELAvCOkkGyfakHOC51I6+yafmX97io
ZvHjvTIOS1BeXQHVEWjs6s1P+F2v1pzl3ozvKCVDecK76WCd0RZWqMvOW9nXQkN3
XXKzYXBb4ZwcN3dCSlsCnIc2TdAJ2u0B4EubAyVRBGqFKV19uRK+geBInBsSuD0c
iE5aJkef4WnomDnGjQdpQZCYcpnwaG2qhLvdJ69jqw5Q6KdRKIQduCY5HGBR9s2Y
iBUX6gvtKxuVh3zAVBG9Gxt7MNRg9aPeqXGc4r5t13FyhPtxJDUULsafUVFMqY20
wmpry30hTOPveh//AWN88dS0gCuTCDFWTDqWfeVv8lnhm6+swEmDAHzamZv1EK1p
2HLG4a88e5+0gILmki/FRZEyk/tGwydmuukKyD442tyH6URAk637Frv9qQQO3xJS
5rWWL0j7JE942VQrLGtM93fQCnZdhrhX4rQQ8henRt1F2PjWyuA=
=7b7d
-----END PGP SIGNATURE-----

--JMngEWmMcPHWStrIjEXor47fA6wpJJMRn--
