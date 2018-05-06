Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3524759-1525627201-2-3814990073803816220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525627201; b=iVUBD0IEQz8c5gFTnmvee932s9j1biK0ADZDHNKcXwOGqm+sEU
    aA1Ug7tFNkXy6moY8BKH7q1+Zvk9ThQ2bUXKopjUfNBLNaUwqVD7xqyDrsPYMPxP
    hFvouY6iWaQLYKrU3gNsApOvu8gOKRP3+xT7pXu6I9CqfGZiqVTvgJG9Lw7iiQ9h
    /ZX4/W3Bpr8jmAH2bhgrLUOgCFCRIRO1al/PXB97ghfMovs6rgvS5ePOjM7Dgg5O
    V1hWmFcdl395yLWoPPx1ewyDFd2AG5qpeIcpk21Blc+6WPL4p5YciqUCp+UCALfr
    LKO5xXkWQPVdYeH2RGiM1h+HOkMIoCRn4aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525627201; bh=050M/
    J0rVW2D6auUk/2rcr7wbBhjERrIIk0CBL+m0lY=; b=K0LxfOOOi6OfRG3XPDTEb
    AE723jid49Od7SyujND6IutFvnPCsynZItqRqXcvs10x6zsPVeF43+sXn9qaPdit
    L9M/YCbYFGAA2TM22jvJdu6Caw2pzuQuNdKnht4gfn1LDyaiKO6zFsqlb6I1z/WG
    kvSXMlZ/SAjoTW4jy6Jc2LF6Y/vIxmFhbMpqI5RECiNO0VbQYUtxoa3v3PdHU4FB
    cnE5+3DkV7/lnqv+Ay5fbN27r4QHiaLkzaT9vIiqSO7Mro2rsDoZF9UugzczH3Gc
    KJ6xHC7Qls58XtIhE1oVFeVkHd/Hfo4eugHTHe4K5pUMvnjfVal+0N9a989SvBx+
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=eKiF2K6n x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=K1rzcMlv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=eKiF2K6n x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=K1rzcMlv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPcTXIJFoMAK4l4jvOVL4etK80hVGUNVKvToCCe4Ofkn0xNw2xgvlFznfONvtZXnpB3Os9/PLYpi3felOH1n+6V0o0LeONx/dRk6Hukhcg6NhkZCf9rB
    kQP29kUbRYHBRJ6hrrOd26djhNr6tozTl3k3WheCNzbuE4ddPk897gDmDwNfiyf6T9PKlaFTqPPC0UUJ+kutyrwLxvZEVJNZhWR9ojP6mKfry68BZy+y2xbt
    bnmk24ouUf6lgtetoz4JsQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=IhivsVMAUfDZFKVpTVUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZptpObpLtHoPuLPIpyt52iLN28pgxu+mLP5jSnIsyDPvREA389U90vzOuNV5uGMYPApStTBmw==
Date: Sun, 6 May 2018 20:19:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: simplify procfs code for seq_file instances V2
Message-ID: <20180506171948.GA769@avx2>
References: <20180425154827.32251-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 05:47:47PM +0200, Christoph Hellwig wrote:
> Changes since V1:
>  - open code proc_create_data to avoid setting not fully initialized
>    entries live
>  - use unsigned int for state_size

Need this to maintain sizeof(struct proc_dir_entry):

Otherwise ACK fs/proc/ part.

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 6d171485c45b..a318ae5b36b4 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -48,8 +48,8 @@ struct proc_dir_entry {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
 	};
-	unsigned int state_size;
 	void *data;
+	unsigned int state_size;
 	unsigned int low_ino;
 	nlink_t nlink;
 	kuid_t uid;
@@ -62,9 +62,9 @@ struct proc_dir_entry {
 	umode_t mode;
 	u8 namelen;
 #ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-139)
+#define SIZEOF_PDE_INLINE_NAME	(192-155)
 #else
-#define SIZEOF_PDE_INLINE_NAME	(128-87)
+#define SIZEOF_PDE_INLINE_NAME	(128-95)
 #endif
 	char inline_name[SIZEOF_PDE_INLINE_NAME];
 } __randomize_layout;
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index baf1994289ce..7d94fa005b0d 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -40,7 +40,7 @@ static struct net *get_proc_net(const struct inode *inode)
 
 static int seq_open_net(struct inode *inode, struct file *file)
 {
-	size_t state_size = PDE(inode)->state_size;
+	unsigned int state_size = PDE(inode)->state_size;
 	struct seq_net_private *p;
 	struct net *net;
 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
