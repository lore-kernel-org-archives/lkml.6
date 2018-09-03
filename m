Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0CDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D412086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D412086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeIDAvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:51:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:33901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeIDAvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:51:00 -0400
Received: from [192.168.123.96] ([88.152.14.153]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIuft-1fuRQm2gMT-002YAz; Mon, 03
 Sep 2018 22:29:05 +0200
Subject: Re: [PATCH 1/1] docs: kernel-doc: fix parsing of function pointers
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180903184153.9368-1-xypron.glpk@gmx.de>
 <20180903130043.059b2e82@lwn.net>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <b0bff870-c3c1-20e8-6609-f93f59da8624@gmx.de>
Date:   Mon, 3 Sep 2018 22:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903130043.059b2e82@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X13lyA/edbuc6Aq8bMZSAkJ25suIOBcepQFfk1AA10rU5Sq07Ov
 jwBS5GBidWWeXdnHiEVHUX3ggv7Ac3Mkpb/t1oqA4haodln1VKID+DNMvlVAysqHUPUq5Xa
 fggh6hROzgL5RiXuB79XILwt/+XcdYVdKuKuZKH/Qh3S6h2AcZ2P25cWZvXYmVDp/7S2CXR
 R3QpXvBvHT0I687kkCcLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xFv6B0w78q8=:pFNJSGyovPebXDHncW2Vnc
 WA68POVZdVG6kg02noXggKQvsdkA/J7EcWsCTc/jODgMFGSR+jZxGoLjYp+13WSTWOXEeCl3F
 GqFi/vPuoqQgMKj0HAergxv0tnHUg6Wz5DdkoacyfFRl1p14GEbayCtMjCgEK7XL3A/WY83LK
 n0Sb67uvU5pUGRDSfKGmjDwghuHfMWuAOoUD0TF7XKIAa2OljEL0DKOlJb/kNfafEJryu4JhI
 BISisJjLlzZdg5B4tWb7lmpGE5Uy/SAzJ6NAMy2B/laDN3mH8e6H0x0zN/Vmez3eO60DZLrup
 sXiZAOl/ou9OSn0Fz9i9TC30RgTGUI6XAW50qHbECzIZWwCgtddbU/0P8LlkLnRXrhT7iHrzF
 deptGLLMI4tTTCEElYdfgfvYqAlPsq7DRfXCI3VrZOezdkSt7l9hUieu43JWuGys0mw9xEylu
 Tde7fMGl2Mdw0sR6W3R/aHA2j8PIiCfbjta+YM8ny7T6A+LGneCrcXNZQ0U+WlaJfp4lDP5z1
 nO9k4YJbZ9KanQdm3ncFHSo7UA6JRBbxhG+HWFBECZ+zPwvBJT0Oh7U+fas1bb3zUyQO+iqAp
 rzXwjV648iEMQ/nwpwSSRhAgpOBsfFp4tpNek1ySFFljhJiPtuMY/8fARYFBKoGThhKPjkPVY
 33aNLQA4BFr2FijYT5oVafBy4F53Jmdu/2al/ZwEgvaU89JVBXbPYuWVAgvnWy2mFBBK+rWgB
 FDRlRZcWB5mUDJ6db6KsTnDH/+SRf57KEfecP+QloXjUeiRqso0kseVdraMFj9ycRif/L8YmT
 lEuJEFw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:00 PM, Jonathan Corbet wrote:
> On Mon,  3 Sep 2018 20:41:53 +0200
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
>> The same script kernel-doc is used by the U-Boot project.
> 
> Interesting, I didn't know that.  Please pass on my condolences :)
>>
>> kernel-doc fails to parse function definitions like the one below
>>
>> efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
>> 			      void (EFIAPI *notify_function) (
>> 					struct efi_event *event,
>> 					void *context),
>> 			      void *notify_context, efi_guid_t *group,
>> 			      struct efi_event **event)
>> {
>>
>> due to the "EFIAPI" attribute preceding the function name.
> 
> This is a good description of the problem; a proper changelog should
> really say what the patch *does* about the problem too.  Especially
> since...
> 

Thanks for reviewing.

>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>  scripts/kernel-doc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 31a34ced55a3..597e3223b791 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1381,7 +1381,7 @@ sub create_parameterlist($$$$) {
>>  	} elsif ($arg =~ m/\(.+\)\s*\(/) {

This matches anything that is not even remotely a function pointer, e.g.
"( )(".

>>  	    # pointer-to-function
>>  	    $arg =~ tr/#/,/;
>> -	    $arg =~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;

m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
           ^
Here we allow for 0..1 asterixes.

If there is no asterix it is not a function pointer. Why should we care
for this case?

We do not allow for a space preceding the asterix, though it is
perfectly legal (though it is not the preferred formatting).

Probably we should start with collecting the different test cases that
the regex have to encompass. I already see the following possible
parameters:

int (*f)(int a)
int (* f)(int a)
int ( *f)(int a)
int ( * f)(int a)
int (FOO *f)(int a)
int (__attrib__((ms_abi)) *f)(int a)
int (*f(int b))(int a)

Which other cases do you see?

Best regards

Heinrich

>> +	    $arg =~ m/[^\(]+\([\w\s]*\*?\s*([\w\.]*)\s*\)/;
> 
> The meaning of this change doesn't just jump off the screen, even for
> folks who are accustomed to reading regexes.  It would be nice to explain
> what is actually being changed and what the expected new behavior is.  It
> appears to be consuming any normal text/white space prior to the optional
> "*".  Are you sure it doesn't overshoot and consume too much if the *
> isn't there?

