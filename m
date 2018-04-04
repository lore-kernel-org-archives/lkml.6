Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3600301-1522826668-5-11212202854337110134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522826667; b=PxUeLOCFYU2sJNpK9jurejlIu2/WV0p3neKoEZIbJJfi9L0CRH
    hNsfPiH+uQDo49WvKMKgH/cqyYVXnRMijjlLoBYHk3VQzRepBGEW/QyXXlEgfTRO
    SXYpJ1m/g4n8oD1nn9ADT8tohhhOR+wvOdofnpmOEocnydAotGdjjk3wWSogO2gl
    8N2sZPC5k0IffP5b3ZcpleUZlqMgEAoduCLp5r8RUUtJ6+hGXZY+qxjnJwAl+kFa
    LiAomW+XdbJ0OKfhny0dHXpRH0JoaPhk/ZVSreY39XQoF3BJCYdw0UpfDcM3WqHr
    YvF6zzgtoQHD0zCu4O8QwVUud8VqeSjbSZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:in-reply-to:references:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522826667; bh=RJ9FE
    NyvWfcdDjt0t1jFoxYchMVM31whBEcnCleBkzQ=; b=LjbP5PgiJbE2tP8y1L0ZP
    KvUH0i/KIr2kyqEVBy9rlp3HrRgjnLdJAE2bV01A/tPgWEFC9XoyiX8/hkrPoESP
    IxPWXniLhZV8q+0Lff6oJJKVFqJ7rL7EqySBsqsgFctil5gn5kmIOX4gdch+W7zE
    YTyHAgtBLjeSIqlRvEh+QrHW5u97+e29gSBjCqfbgicexEVOHWjMC0ysc0st/bje
    +6Ky3rsacq5xFP3DvqtGUs7StossccdAD7xa0D5vHEkKHbqphcKTO5tgTUHXPy3B
    AowH9Y89mmo4/z+QFJpB33gspFTTKFqrlS47Jdh6LuzSN26He1wrKhhmTQ0Fi4X9
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Dm0m+2t4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=Dm0m+2t4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA0eivCBF/Be9+cqV61BMAUJoMXYa+Rh0XrZvg04mnYkdh2NfexymMoWmd8KQ12UJ/5YZJCtE4kJ99Dr4UzLCnqqsjCV17bhYGECHRKmC/lkGSYL9fH8
    k/so1NOBKSGA9EKx4iSEArhBGt28cOUmgf3BPMeSNsV7lg+1emWukhWHUwT65ItaqBK/bvUvKtiuCNJ+7OyfoN/IDSZa01CiWbQL2UBc9TI6JsCkRjillRGe
    7iB5dJNcmIEippp8o6LVjQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8
    a=4sjg0c151KBCE39N1dUA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20180404072415epoutp0190af4cd7892e2690bc1eb6e349001309~iKsZ7hqUD0031300313epoutp01a
X-AuditID: b6c32a38-d5bff70000001082-28-5ac47d9ffdbb
Date: Wed, 04 Apr 2018 16:24:10 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation failures
Message-id: <20180404072410.GA31134@ubuntu>
MIME-version: 1.0
Content-disposition: inline
In-reply-to: <20180403104052.6wbomdguifrmlmpz@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTV3d+7ZEog7b9yhbrJi5ksnj9bzqL
 xZ4zv9gt7k94xGrRvHg9m8WyB6cZLbbekra4vGsOm8XJbfIWW7p+sDpweTQ3vmf1uLfvMIvH
 zll32T32z13D7rF3S5bHx6e3WDz6tqxi9Pi8SS6AIyrVJiM1MSW1SCE1Lzk/JTMv3VbJOzje
 Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
 rVK0oaGRnqGBuZ6RkZGeiXmslZEpUElCasayvuiC3SIVP559ZG9g3M3fxcjJISFgIvH7yWXG
 LkYuDiGBHYwS867dZIZwvjNKTPlwi62LkQOsatd3foj4bkaJnz/aWCGcl4wSR3vfs4GMYhFQ
 lXj1cwaYzSagKbGx+xojiC0ioCNxufMHO0gDs8A3Rol7nTeZQBLCAv4S/7pfsIDYvALaEp9X
 32CEsAUlfky+BxZnBmo+e2wdI4QtLfHo7wx2EJtTwFRi/+H/rCC2qICKxJST29gg/nnNJrGm
 2RDCdpE4v6aBBcIWlnh1fAs7xDfSEpeO2kKEqyUWXNkBVVIjcfP/UiYI21iit+cCM8RaPol3
 X3tYIVp5JTrahCBKPCRuX/vEDmE7Ssz69BQacEcZJebuu8c+gVF2FpJvZiH5ZhaSbxYwMq9i
 FEstKM5NTy02LDDRK07MLS7NS9dLzs/dxAhOhloWOxj3nPM5xCjAwajEw7ti0eEoIdbEsuLK
 3EOMEhzMSiK8O5SORAnxpiRWVqUW5ccXleakFh9iNAVGyURmKdHkfGCiziuJNzSxNDAxMzI1
 NTSwMFES5w0IcIkSEkhPLEnNTk0tSC2C6WPi4JRqYGQJ6Pm0J6HF6tZm26ueE3qOvW0z0l5U
 yKyrHxvkp8HkuXDWwUf9IbcVdD+dLU1cx/iDj03zPG/U81fz/289vMQpPNHN+tjDVWt3aWbl
 fsoJPfiDmzvjwLLdj2a92jHv6JrSAM6m+Toy+mejuxN2N5qIb5EOv765/cVsAT1nmReZTtJy
 H65vElJiKc5INNRiLipOBAAtyXIxnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t9jAd35tUeiDLqOsVusm7iQyeL1v+ks
 FnvO/GK3uD/hEatF8+L1bBbLHpxmtNh6S9ri8q45bBYnt8lbbOn6werA5dHc+J7V496+wywe
 O2fdZffYP3cNu8feLVkeH5/eYvHo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSujGV90QW7RSp+
 PPvI3sC4m7+LkYNDQsBEYtd3IJOLQ0hgJ6PEvMc/mCCcl4wS888cYO5i5ORgEVCVePVzBhuI
 zSagKbGx+xojiC0ioCNxufMHO0gDs8A3Rok50++wgEwVFvCVuNodDFLDK6At8Xn1DUaIoccZ
 JfZ9vc0MkRCU+DH5HguIzSygJbF+53EmCFta4tHfGewgNqeAqcT+w/9ZQWxRARWJKSe3sU1g
 5J+FpH0WkvZZSNoXMDKvYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIjIVth7X6djDe
 XxJ/iFGAg1GJh3fFosNRQqyJZcWVuYcYJTiYlUR4dygdiRLiTUmsrEotyo8vKs1JLT7EKM3B
 oiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB0bFt8ox+6a975KtvNG6df9N2I8fdiKI/E23q
 Ipj+muuoda+0EefhvNTumnG73z5t5+H4PwamNR9zfGbIF3acsfQ7GmNWcdh6xWkXmYyM2S3+
 Tatfyr45rNr7g6fw1Uq2ZnWdjMhPfge/hFadmlV6wbp8SVZ5+EGGvCbJi3f8DB8XR0mlHxZS
 YinOSDTUYi4qTgQAOuEIB4ECAAA=
X-CMS-MailID: 20180404072415epcas1p46b3af0ce31a5e68bfcd897544b94a513
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
X-RootMTR: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
 <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
 <20180403104052.6wbomdguifrmlmpz@mwanda>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, baijiaju1990@gmail.com, forest@alittletooquiet.net,
 santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 01:40:52PM +0300, Dan Carpenter wrote:
> >  		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> > -
> > +		if (!desc->rd_info) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> >  		if (!device_alloc_rx_buf(priv, desc))
> >  			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
> >  
> 
> We need to handle the case where device_alloc_rx_buf() fails as well...

Hi Dan, thanks for your comments! I will write a patch v5 including this fix.

> Some years back, I wrote a post about error handling that might be
> helpful:
> https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ

This post is very helpful to me, Thank you.

> You are using "one err" and "do nothing" style error handling which are
> described in the post.

Sorry, I didn't fully understand "one err" and "do nothing" style error
handling of this code. The reason using goto instead of returns directly
was that for freeing previously allocated "rd_info"s in the for loop.
Please see below comment.


> > @@ -550,20 +554,29 @@ static void device_init_rd0_ring(struct vnt_private *priv)
> >  	if (i > 0)
> >  		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
> >  	priv->pCurrRD[0] = &priv->aRD0Ring[0];
> > +
> > +	return 0;
> > +error:
> > +	device_free_rd0_ring(priv);
> > +	return ret;
> >  }
> 
> Of course, Jia-Ju Bai is correct to say that this is a layering
> violation.  Each function should only clean up after its self.
> 
> Also, this is a very typical "one err" style bug which I explain about
> in my g+ post.  The rule that applies here is that you should only free
> things which have been allocated.  Since we only partially allocated the
> rd0 ring, device_free_rd0_ring() will crash when we do:
> 
> 		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> 				 priv->rx_buf_sz, DMA_FROM_DEVICE);
> 
> "rd_info" is NULL so rd_info->skb_dma is a NULL dereference.

For dealing with this problem, I added below code on patch v3. I think it
would not make Null dereferencing issues, because it will not enter 
dma_unmap_single(), if "rd_info" is Null.

+               if (rd_info) {
+                       dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
+                                       priv->rx_buf_sz, DMA_FROM_DEVICE);
+                       dev_kfree_skb(rd_info->skb);
+                       kfree(desc->rd_info);
+               }

I would appreciate for your opinions what would be better way for freeing
allocated "rd_info"s in the loop previously.

Best regards,
Ji-Hun
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
