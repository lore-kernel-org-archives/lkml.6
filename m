Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3881655-1519031774-2-5385905304423523010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519031773; b=PL9lTilduB60GaeHA7YwlFI3V12jpnt1sN4mpYw6qJJSILJ
    zwnF+ouidbLhy6YzQYglDi49Ly4iLRaUyYXSTHH5LWhx4Sclm5/BS8vIJPSmm9TU
    WfcSfiGcBtqkhMWBYxnBgSRVo3SLeXOKGnyOg/iuMweDPQvf7TvUOL5QHniw00l/
    daXb+nRsjwGVQeRXz6eqaFyKC1GO5BlemYdVtIUb6FU40bPDjwSmHbAL2miSzhXV
    6d/AHcSK5yx0v9ihOqODTQC43zSaeAkwNRpcCzO4e87YSL/K2+J4HMK1iJKajejm
    HP6LH2gNehIm5xImax60zzg4B8gSOoLTHp6OIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519031773; bh=c
    Z1VWvyrBqEnzshYOARKIpXAcJE1JnyzcK5dM+EKhvA=; b=DYboIR1l4Ng74fvXs
    dhpBx09aR3dMIcwibqBEP9mOIf0LldjjljM959ArI+Zbi+BYrOIJuffL/ZQLc+pj
    AqpByfM2SODwEFaF7JhLKSDdjFIxHcE3DFhSZDdHiroUJeOLebiMnUJUSxKrcvbS
    BIY1eyL20r+yI0KW+Xtvf9rjYjvWsH6HUcx0B4SUK6Y94/Ong/5MPt9FNfCNhn0i
    JseoyWXVWQQ0d5etxfBqn3OfgBRRquPgs0rvLtzjqOE9dfiwSZxGXTqts1arJs+u
    I4H/O/F1lW9Vew9489z1wVFYyJUnW4JkE2Z7CalDV/n6Fc/QdqqxBVAfdqmD6rqf
    rHFHw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=WvvozCfj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=WvvozCfj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Feb 2018 12:15:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] Staging: gdm724x: LTE: Fix trailing open parenthesis
 code style issue.
Message-ID: <20180219091550.7nhyjfqvwob6cc2c@mwanda>
References: <20180216214008.17105-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180216214008.17105-1-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808
 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=763
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802190116
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 01:40:08PM -0800, Quytelda Kahja wrote:
> @@ -728,17 +731,21 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
>  {
>  	struct nic *nic = netdev_priv(dev);
>  	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
> +	struct gdm_endian *dft_endian;
> +	struct gdm_endian *nic_endian;
>  
>  	if (pdn_table->activate) {
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
> +		dft_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
> +		nic_endian = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);


We don't need both dft_endian abd nic_endian since they're the same
endianness.  Otherwise, this is a nice cleanup.

> +
> +		nic->pdn_table.dft_eps_id =
> +			gdm_dev32_to_cpu(dft_endian,
> +					 pdn_table->dft_eps_id);
> +		nic->pdn_table.nic_type =
> +			gdm_dev32_to_cpu(nic_endian,
> +					 pdn_table->nic_type);
>  
>  		netdev_info(dev, "pdn activated, nic_type=0x%x\n",
>  			    nic->pdn_table.nic_type);

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
