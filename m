Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDQPMG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:12:06 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48922 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeDQPMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:12:05 -0400
Subject: Re: [PATCH v2] X.509: unpack RSA signatureValue field from BIT STRING
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc: David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20180417134032epcas3p21dbb2d3a6d8650cd64e147d2ce89e6ea@epcas3p2.samsung.com>
 <6f5cdb8a-809e-6651-0e32-711d415a8b38@maciej.szmigiero.name>
 <f29df54e-48e1-12e0-f2d2-fd8353cc445f@partner.samsung.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <7497a6f6-b9fc-a249-a6c8-42ff2723aa4a@maciej.szmigiero.name>
Date: Tue, 17 Apr 2018 17:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f29df54e-48e1-12e0-f2d2-fd8353cc445f@partner.samsung.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 17:07, Kamil Konieczny wrote:
> 
> 
> On 17.04.2018 15:39, Maciej S. Szmigiero wrote:
>> The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
>> For RSA signatures this BIT STRING is of so-called primitive subtype, which
>> contains a u8 prefix indicating a count of unused bits in the encoding.
>>
>> We have to strip this prefix from signature data, just as we already do for
>> key data in x509_extract_key_data() function.
>>
>> This wasn't noticed earlier because this prefix byte is zero for RSA key
>> sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
>> prefixes has no bearing on its value.
>>
>> The signature length, however was incorrect, which is a problem for RSA
>> implementations that need it to be exactly correct (like AMD CCP).
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> your e-mail address looks incorrect
> 
> [...]
> 

What's wrong with it?

Maciej
