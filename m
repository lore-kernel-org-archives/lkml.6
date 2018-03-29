Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3703489-1522288611-2-13827782257003769005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522288610; b=Oite0lHPODDXy67/jJ1/tUhapamYSzS6C7qBRjGgO1boKjO
    yjBqtBuXGTfqYQ8KaaeWSuY9PwbVO70ij5Clso1+87RBhO5vSnlRztAvsszVCpQL
    cWfF7gRbUqxrLlRyTI6Zo3vI3sY8/RLSisqqBYlzvVk1aCvB2g9cj0csZqilD2a0
    DbTwegAIA+uCTcGMFXz/LarzgpbRO7sYEw/PJ2nr8MN8+Pg1mYjyJUTkoFs5j2cl
    nP4HJgTzkYSQDwKXXOBDOU2GW4VuCykh+fZNB9xdRolxAMMbMz35wAPpbjUvrVqC
    +x+Zr2d+zto0vV3jhfAtduERQ4gUKvQRa5le2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:in-reply-to:references:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522288610; bh=0
    FuFEhkZIqNkfaY39zHaHfXeMps2ax40dKHgCSktehw=; b=iyfaX2MFXOoYB5qeD
    eOgQXffEKB9m60lvgwrJZSRbboh8GLKDvt4brauED6BN6Y++vDrDg40vfdxTUPGT
    dbtyQSaSDu5eGhVvemkEDc8vw86jWu2zyU1dA6I54a9LBOvHg4UOWam2U3jsrd/r
    xJM3EMZ7VnzeCni1pxuM+FBY01LX76YYb6q6bdx2eAOfTxsFKZ1eeB1N1UNP2bDu
    +sT+J9fKgiFi+VXMFef/sGi6lLZLSVr2+tbyW1z772qcVO9kG0zHIC7RCmBubSa6
    nxEJ958YGPTil7aokvRKuups17r5M4aHiWWSqyrLTQoM+jStBZ2Dol3GiR/sSS4h
    f1rug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MwEUkwR/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MwEUkwR/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDwtsDrYullKhcEY35Y9+5yOYYeoTQvbaQdVlPesjTTaIkn5atR0HrDN1+z9WC1jizZIM/Uk78XEcjAwC2q2EIDDaRWYW0ndN4/pwf/LxoP7dGw1iv4M
    e+PcQRTe0BTavnoCeuxe/FXsQcdM0KEcgsqzGf9gR9qsWa/1YZXUkN6v56wq31L739tc4PxZ7kytm/gyi4pxK6T+rVDCR5WL79rFO5CCdUCqhzt7vYVneMep
    mvQ2AjFp0qrpsccqBB/gyQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=bTfdiLgpTg8VEGSHlQgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20180329015639epoutp03c04f4938d40f5136b4ed7dab4d4423ce~gQWp1ORKq1015210152epoutp03n
X-AuditID: b6c32a48-8d9ff70000000ff2-2c-5abc47d67303
Date: Thu, 29 Mar 2018 10:56:37 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: baijiaju1990@gmail.com, gregkh@linuxfoundation.org,
 forest@alittletooquiet.net
Subject: Re: [PATCH] staging: vt6655: check for memory allocation failures
Message-id: <20180329015637.GA9416@ubuntu>
MIME-version: 1.0
Content-disposition: inline
In-reply-to: <fc4cd041-f8b4-f799-916d-9df790efbba7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTTPe6+54og+3/GC3WTVzIZHHm/Vkm
 iz1nfrFb3J/wiNWiefF6NotlD04zWmy9JW1xedccNouT2+QttnT9YHXg8mhufM/qcW/fYRaP
 nbPusnvsn7uG3WPvliyPvi2rGD0+b5ILYI9KtclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
 1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYqsUbWho
 pGdoYK5nZGSkZ2Iea2VkClSSkJqxdeNU1oJ9HBUnbt9kamB8wNbFyMkhIWAicWnVaSCbi0NI
 YAejxNF5HewQzndGie87mthhqjZs72eESGxglPh07SxU1UtGif9bHzGCVLEIqEpcvDINbC6b
 gKbExu5rYHERgRCJi9NngO1gFtjFKLH690lmkISwgJfE+tNtYCt4BbQk3p6bzwRhC0r8mHyP
 BcRmFtCROHtsHSOELS3x6O8MsHpOAVuJ9S3TWEFsUQEViSknt0E9dJ9N4s82fwjbReLTiffM
 ELawxKvjW6DekZZ4tmojI4RdLbHgyg4WCLtG4ub/pUwQtrFEb88FZoi9fBIdh/8C9XIAxXkl
 OtqEIEo8JO537Ica6Six5NM/aKCcYZSYdnQm2wRG2VlI3pmF5J1ZSN5ZwMi8ilEstaA4Nz21
 2KjARK84Mbe4NC9dLzk/dxMjOBFqeexgPHDO5xCjAAejEg+vxaLdUUKsiWXFlbmHGCU4mJVE
 eN9rAIV4UxIrq1KL8uOLSnNSiw8xmgLjZCKzlGhyPjBJ55XEG5pYGpiYmRmaG5kamCuJ87YF
 uEQJCaQnlqRmp6YWpBbB9DFxcEo1MDbyPFbLqkx0yJfbbLT4Tlbgss7Vmi5HWsUnHH+e2fxP
 2JZlgluf9dM83tmTYu8WeB4y19W8uLB599fND4oFDgmv8Nl59rj9kpvJbuVv11nKPbOxVON6
 8szg6xajs2+KO35Jrn5wuCPGl9U2bjb3y+TkDVp8K/52vstqOPJHvu1rXJrnhqqdi5RYijMS
 DbWYi4oTAW1kMS+aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t9jQd1r7nuiDOZNNbJYN3Ehk8WZ92eZ
 LPac+cVucX/CI1aL5sXr2SyWPTjNaLH1lrTF5V1z2CxObpO32NL1g9WBy6O58T2rx719h1k8
 ds66y+6xf+4ado+9W7I8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PrxqmsBfs4Kk7cvsnU
 wPiArYuRk0NCwERiw/Z+xi5GLg4hgXWMEv+a21kgnJeMErPvbWQFqWIRUJW4eGUaWAebgKbE
 xu5rjCC2iECIxOtr65hAGpgFdjFKHJm9EqxIWMBLYv3pNnYQm1dAS+LtuflMEFPPMUrs+v6G
 GSIhKPFj8j0WEJsZqGj9zuNMELa0xKO/M8CaOQVsJda3TAO7QlRARWLKyW1sExj5ZyFpn4Wk
 fRaS9gWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQLjYNthrf4djI+XxB9iFOBg
 VOLhtVi0O0qINbGsuDL3EKMEB7OSCO97DaAQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FC
 AumJJanZqakFqUUwWSYOTqkGxj3uWdFczo2CBTPexvvrCRYZtaozifXXr2x5si7x0cbGgDS9
 e3HFi2cXrC7cpamfeutl75tVrzZY/4z8bLRO8uVU3w8lXOvWHrc7y6X7ylnIf+2/O5wP3h55
 3RDS/7niAbsfr7bo5+7UE286r+rebE35POdekd7jH8aMqsKVEkn/d5vv9CrUVmIpzkg01GIu
 Kk4EAAcZsKh/AgAA
X-CMS-MailID: 20180329015638epcas2p1b3684edb9c77a0e962cd1da0fc52c305
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180328063144epcas1p305216b582520b884b09c93a7ad591660
X-RootMTR: 20180328063144epcas1p305216b582520b884b09c93a7ad591660
References: <CGME20180328063144epcas1p305216b582520b884b09c93a7ad591660@epcas1p3.samsung.com>
 <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
 <fc4cd041-f8b4-f799-916d-9df790efbba7@gmail.com>
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
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 05:55:57PM +0800, Jia-Ju Bai wrote:
> >@@ -646,7 +649,8 @@ static void device_init_td1_ring(struct vnt_private *priv)
> >  	     i++, curr += sizeof(struct vnt_tx_desc)) {
> >  		desc = &priv->apTD1Rings[i];
> >  		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
> >-
> >+		if (WARN_ON(!desc->td_info))
> >+			return;
> >  		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
> >  		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
> 
> I think the bugs you found are right.
> But your patch is not correct, because it is dangerous to return directly.
> I think you should return an error and then implement error handling
> code for these functions.
> 
Yes, it needs to free previous allocated values in the for loop. Directly
return could make memory leaks. I am going to make patch v2. 

- Delete WARN_ON which could make crashes on some machines.
- Add freeing sequences for previously allocated memory when kzalloc()
  failed instead of returning directly.

Does these changes would be fine on this bug?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
