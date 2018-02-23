Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBWJGg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:06:36 -0500
Received: from mout.web.de ([217.72.192.78]:59307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeBWJGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:06:32 -0500
Subject: Re: [0/8] target-iSCSI: Adjustments for several function
 implementations
To: Dan Carpenter <dan.carpenter@oracle.com>, target-devel@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
References: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
 <c9a822a4-248e-c479-9118-4b8ffb1033b1@users.sourceforge.net>
 <20180222143624.7c7241a1@suse.de> <20180222135600.5vv7vzw7sa5metcb@mwanda>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <145b88b1-bd1e-a417-8dce-ff19e35a00fc@users.sourceforge.net>
Date: Fri, 23 Feb 2018 10:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222135600.5vv7vzw7sa5metcb@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:4fZYyLN+hFbwTm4QVh+vq//Y2Az4A+vi1nywvEuZ47lDsDuJ0k7
 vzfs+fsnbK9DSrR90+jwE2Y3IoR/AlVL+GgcXCnbol56siyZGTsOVAW7yKXuXhpM1wvj5a0
 V2IaDAd6eKzjhsDR3JqYJ71z+lUUew/XTIgCVCOvOPYTfdBXHj42vsh59YyhJLAzkhKt7Xq
 5fZ2DsiJ/O6X3eBLP7bUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WwBQvxObP70=:RosvOZTUkmFaA60j/PTvY/
 jZ9sALFegVA/yvYOseqGlPwnQShrBa1Lfbwfu1U6GdzhwaUFA9fNBgEW1D4tKGD6Ik8UPdC27
 rTnz1wyuHz3Ie7xin2CFf0sIQbl2TwM0EURySzeuFbbim1+wzxMWxbgCdeXUjCyH97dzQWLJE
 DBnaQaIoxjr6b/NTYygP6BzqxiamW2cmVQwSlQTO07FLTWGrDcdlIjFR1/7cyEVnqH21RdQ9b
 IViWE05oA/JVCZrjTCA3qsqp0q+T66ZIS8xkLN/uFOxwO3kTC8dYrhmayxEDq4xvy6g30fMtu
 or5xKTYlb59jgvGeidwkmuVY/DTfqnSwrQCXsIa68geD6ygNSzXKrcPQoti1yC7//kB1dDfuo
 +dimgCaWrgQujVit1r6LF98BYn25vBAwrE3EipyolwQhiK8ixc2AXI4kQ2lEqflfDpIxTTIj1
 f8i+OnMJrEmmlB0ILSCg+tZK9ybjr3IRcf8Xu/QERToBfBde1rIgvfGZNMIC1To1HvRShk/iT
 ZtqkgTJYQv7VZxW/ITiVlNCQnGgDSocSLjAFXPLNqXQ8wqXAqPY/OXQMG9+ScisvcCQVDDwJi
 WYsii2k/2NBRqwQ2kPm0131RRgQbx++eTS3QEZL5MKAMHF33tIlLZMRIrZB+UgpqqyP9JstIE
 M8jPxAHLrg/YVazwf06arnqPUhDPAy5tC3zd+L64ioCqmZsinb4WPVrM9/VyUpYt9cKBxM28G
 IukTHOC58KPL9Q3MxTx2peSdOKaB2ZEUk5tt+4XpZmQURBJxCPbz0q5O5BH2b2NFs/VCX9eA/
 GWBoUfczogEIItnBIyLHkHLOUy8rrXqNts1aIFxj2FpWUPHXk0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Calling crypto_free_shash(NULL) is actually fine.

Really?


> It doesn't dereference the parameter, it just does pointer math on it in
> crypto_shash_tfm() and returns if it's NULL in crypto_destroy_tfm().

Can a passed null pointer really work in this function?

https://elixir.bootlin.com/linux/v4.16-rc2/source/include/crypto/hash.h#L684
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/crypto/hash.h?id=0f9da844d87796ac31b04e81ee95e155e9043132#n751

static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
{
	return &tfm->base;
}


Regards,
Markus
