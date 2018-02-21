Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1268855-1519209803-2-10352044428027854344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519209803; b=sU8n+5ow1hqXpK+3lzDBtgvij0wceXiW5TUiyM5g7TVniJT
    mRxVNG6mHCpFkIq7aIkHXDSAtbQnmXpsyTnBLGggfQ4TdC9bHxVrPj47gGENLRsA
    FShPaB70INaoS7vV8oDfXsA2e0FApqX2FlmNv7BTqxTnbD45KNnWbd++3m/XNuTd
    LOOfBhU2o9uOWBKimNdHr+aUKQAutyP/bW/wgexXySm9BRXRUoIKPRhd/MaSg5Q3
    6nRySypqchtXXnJYZMMV4wkCyJj4mIPSvSwInXCEVAMSecAmuMkzhHKdtpd4/5fi
    IPhsLjrYlvYFOwxfGhJzkfKOnABF+BTGlud7ACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519209803; bh=Q
    F2JAtGa10aVUjMn148sxS6DNfmTJMh3YoQks44LuJY=; b=aVhTk2TsgdxfX2/7L
    aszjDiyhK4pNY9LseYW3MgiGzVqe8wNpGHAl9rRsvgkGayCi8vfvPRk6mVtDTLsj
    dHOdqFNyc0j5B/rM9RbwFp4zj3RMFDrZUIqxIlIde99IsECycoFSjdktaw87NJ97
    i6iAoiMdDi5RmBhR0ri1PmhT4rXXH7ItSrEpLgeHc//ROuhSL/ChgeXBLZOwCD43
    UABt6PEdtSpGZr2FF3MDazd1Si5JJ/9Ffmx5zZWnFED2JM+gZJKj6673b0xRieyP
    WHGmyd2npmkOKvZwSGLslESSmm0X3Hpvpe0X113nVyMn4JsLFXMSY5k5faVnceFF
    +fgNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hPAtigAA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hPAtigAA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 21 Feb 2018 13:43:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] Staging: gdm724x: LTE: Fix trailing open parentheses.
Message-ID: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
References: <20180219091550.7nhyjfqvwob6cc2c@mwanda>
 <20180221102017.17211-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180221102017.17211-1-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810
 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210132
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 jonathankim@gctsemi.com, linux-kernel@vger.kernel.org, deanahn@gctsemi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is fine.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

But I have a some comments for later.

On Wed, Feb 21, 2018 at 02:20:17AM -0800, Quytelda Kahja wrote:
> @@ -509,8 +511,9 @@ static struct net_device_stats *gdm_lte_stats(struct net_device *dev)
>  
>  static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
>  {
> -	struct nic *nic = netdev_priv(dev);
> +	struct phy_dev *phy_dev = ((struct nic *)netdev_priv(dev))->phy_dev;
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a bit unsightly.  Better to make it two assignments:

	struct nic *nic = netdev_priv(dev);
	struct phy_dev *phy_dev = nic->phy_dev;

>  	struct hci_packet *hci = (struct hci_packet *)buf;
> +	int length;
>  	int idx;
>  	int ret;
>  
> @@ -518,11 +521,9 @@ static int gdm_lte_event_send(struct net_device *dev, char *buf, int len)
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	return netlink_send(lte_event.sock, idx, 0, buf,
> -			    gdm_dev16_to_cpu(
> -				    nic->phy_dev->get_endian(
> -					    nic->phy_dev->priv_dev), hci->len)
> -			    + HCI_HEADER_SIZE);
> +	length = gdm_dev16_to_cpu(phy_dev->get_endian(phy_dev->priv_dev),
> +				  hci->len) + HCI_HEADER_SIZE;
> +	return netlink_send(lte_event.sock, idx, 0, buf, length);

It would be nicer to store:

	struct gdm_endian *ed = phy_dev->get_endian(phy_dev->priv_dev);

at the start of the function as well.  Then this looks like:

	length = gdm_dev16_to_cpu(ed, hci->len) + HCI_HEADER_SIZE;
	netlink_send(lte_event.sock, idx, 0, buf, length);

The endian information doesn't need to be a struct any more since
we remove ed->host_ed in 77e8a50149a2 ("staging: gdm724x: Remove test
for host endian").  We should change gdm_dev16_to_cpu() to just take
dev_ed.

>  }
>  
>  static void gdm_lte_event_rcv(struct net_device *dev, u16 type,
> @@ -731,15 +732,13 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
>  	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
>  
>  	if (pdn_table->activate) {
> +		struct gdm_endian *ed;
> +
>  		nic->pdn_table.activate = pdn_table->activate;
> -		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(
> -						nic->phy_dev->get_endian(
> -							nic->phy_dev->priv_dev),
> -						pdn_table->dft_eps_id);
> -		nic->pdn_table.nic_type = gdm_dev32_to_cpu(
> -						nic->phy_dev->get_endian(
> -							nic->phy_dev->priv_dev),
> -						pdn_table->nic_type);
> +
> +		ed = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
> +		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(ed, pdn_table->dft_eps_id);
> +		nic->pdn_table.nic_type = gdm_dev32_to_cpu(ed, pdn_table->nic_type);
>  
>  		netdev_info(dev, "pdn activated, nic_type=0x%x\n",
>  			    nic->pdn_table.nic_type);

Use the same three initial variables here:

	struct nic *nic = netdev_priv(dev);
	struct phy_dev *phy_dev = nic->phy_dev;
	struct gdm_endian *ed = phy_dev->get_endian(nic->phy_dev->priv_dev);

Then reverse the ->active test:

	if (!pdn_table->activate) {
		memset(&nic->pdn_table, 0, sizeof(struct pdn_table));
		netdev_info(dev, "pdn deactivated\n");
		return;
	}

Then pull everything in a tab:

	nic->pdn_table.activate = pdn_table->activate;
	nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(ed, pdn_table->dft_eps_id);
	nic->pdn_table.nic_type = gdm_dev32_to_cpu(ed, pdn_table->nic_type);


regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
