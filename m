Return-Path: <chris@chris-wilson.co.uk>
X-Google-Smtp-Source: AH8x227hgpTmKKLofUIFtQhS8GdiswediVP1ySI3rK+lAFr3XRVHYZzlQq0wnKh7lmuNWxw2zoyJ
ARC-Seal: i=1; a=rsa-sha256; t=1518680241; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9hqB5VR1sThaslUjJupDLs4bs3H5McEh5ckDNHTWuMJYdboBcH8yJ+K9w6SB9wcjh
         ARuvZEuSAFk2AJXvI9FuorW6051w63sW2Y+Wos9ZbbGisuwgFEAc4Ongvk5LyHL16c3Y
         bEW9xGv5tZD0lSciI4aPbuMvDR+TlMuIqN1HBb6tYLmm8BoD4cxuX5Ix1yHaRqm6AP+6
         N8xf2HXtWRdKssWJ16lhICVfCnya+c4JzEkCEU0Mc6soG4yRRzO8iXTaacgJWZU/IJTy
         s+9hOZU1U1kmNKWcEloX80WpOYHaX9H5mecPT8ooYHJ697HnaovH+Hz134WzpDaTb/z0
         ThzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version
         :arc-authentication-results;
        bh=PnYpMaVjjrlu3MBpzUg9kXWxs9vAaMB1TKNNRzvSmj8=;
        b=pf5Xsv93AJ4pIj+jpIG3V74ZOc2bi8Px3JsyTjlzfT2Hij1sopvisMjdgFc4nn+gK8
         /jkxZy9+hQ2mCwKTYi8TZIBgNbBM8fbBuJqo9cKGzcCkkTKWxVqHJYML5WDWFlH2ylMW
         ++zMXrnWeZ0Dz070AKzA5INXZ200mf+DhrZx+AnIadofeEfPbswnk5MswHxDzfEB49vN
         XpgFRWRvsQnITyCqSQqAE9EzNWoeVQLjZvEXD4n24JU6ySfdtXcNXWIm15xRs4HZW0+P
         GxxRv2Cid45TM7AqzRLQXB3mg1H+paXV0dqpUFHZeYGA8vUK6jUke3BnI1GB5p309syz
         7VMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.228.58.192 is neither permitted nor denied by best guess record for domain of chris@chris-wilson.co.uk) smtp.mailfrom=chris@chris-wilson.co.uk
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.228.58.192 is neither permitted nor denied by best guess record for domain of chris@chris-wilson.co.uk) smtp.mailfrom=chris@chris-wilson.co.uk
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jthumshirn@suse.de,
 axboe@kernel.dk, tvrtko.ursulin@intel.com
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
Cc: khandual@linux.vnet.ibm.com
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
Message-ID: <151868021710.15373.766697204394848595@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB
 encodings
Date: Thu, 15 Feb 2018 07:36:57 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592451652733058443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Anshuman Khandual (2018-02-15 03:33:56)
> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
> SG_END definitions without any functional change.
> =

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V2:
> - Changed SG_EMARK as SG_END as per Johannes and Tvrtko
> - Added 'UL' to the constants as per Bart
> =

>  include/linux/scatterlist.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> =

> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 22b2131bcdcd..b6fe1815f5c4 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -65,16 +65,18 @@ struct sg_table {
>   */
>  =

>  #define SG_MAGIC       0x87654321
> +#define SG_CHAIN       0x01UL
> +#define SG_END         0x02UL

The alternative would be BIT(0) and BIT(1), which by the time you write
the constant out in full, as above, become clearer.

I think you also want whitespace between the MAGIC and CHAIN,END so that
the reader doesn't think they refer to some magic encoding of SG_MAGIC.
-Chris
