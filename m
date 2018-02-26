Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519675341-2-13245853061377226818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519675340; b=c3ma5clepTbHlDMM43YZjxU3QUw7kXIqOWq7QC43vTboXMH
    C75tosvNB9MaJHbJ9KiC6NLJa3xAEXQMkUUvEIRPRgHsqxQY1EK3FMB0coT7yvZ5
    Frn/i6goFZRnjICzb7ZMnwT5ULc2+7CF0wKIkFTyXUcbDkQEubeqnxYEoiHibvDN
    XzJiZQdLXm1Or2FLfgurWxuxiuhSK4KV4BVnOyjKbS/5OhbpuyRp7UTUdyUGVHvE
    FW/cb5aj90dSjIQE9hyoPfdTfSgrtgEjBw4xvUJEqH6EchEQU0oFiBcDM6/JVgpv
    bmWbJMONIZ/Nemvx95KHlVSLdWMdzGK2haEF50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519675340; bh=CEb6ujBNxTrJD7n9uqsBb831jpip22gBP1Iep60n0tc=; b=Y
    TzDl7pFRsFv4ZpqiewQV4CrMds4l5RIP3wCaZUPkJwC6p4BQDo89FpAoptD4JDFG
    dlK37yETvInI9aCSdC52kJr2JgbxyhiNdpgLSVFzVn3dIbiVYN5OmqwmEPFyhkUq
    lGphJVlSo4PJbHL2DnrWbDb2e4RKT5tcbNto5Kj+9CvQtZfd+4J2JizH1giKv9cl
    jhqoA4Tsf3g+VILWKt0SF9EKKa6xtsecHOj4/MQmRhEjpEUSZoaiBy/XsWaAm9SZ
    fdGnk0I6UlQVXngHLz3M9LFk4OUJ3iWSwrDcJL91UCbKN7YWl42ZxrRLL/i7Omq6
    B8GylqlSj0oq9YSlCbQJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JIZ9eRcZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JIZ9eRcZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbeBZUCS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:02:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38998 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeBZUCR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:02:17 -0500
Subject: Re: [PATCH 1/2] xen: fix out-of-bounds irq unbind for MSI message
 groups
To: Amit Shah <aams@amazon.com>, xen-devel@lists.xenproject.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Liu Shuo <shuo.a.liu@intel.com>,
        Anoob Soman <anoob.soman@citrix.com>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
 <1519666595-41362-2-git-send-email-aams@amazon.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <db4a0e0b-31cf-9c37-ba89-c0e7b6c99d87@oracle.com>
Date: Mon, 26 Feb 2018 15:02:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519666595-41362-2-git-send-email-aams@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260253
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:36 PM, Amit Shah wrote:
> When an MSI descriptor was not available, the error path would try to
> unbind an irq that was never acquired - potentially unbinding an
> unrelated irq.
>
> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> CC: <stable@vger.kernel.org>
> CC: Roger Pau Monné <roger.pau@citrix.com>
> CC: David Vrabel <david.vrabel@citrix.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Eduardo Valentin <eduval@amazon.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Liu Shuo <shuo.a.liu@intel.com>
> CC: Anoob Soman <anoob.soman@citrix.com>
> Signed-off-by: Amit Shah <aams@amazon.com>
> ---
>  drivers/xen/events/events_base.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 1ab4bd1..b6b8b29 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -749,6 +749,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  	}
>  
>  	ret = irq_set_msi_desc(irq, msidesc);
> +	i--;
>  	if (ret < 0)
>  		goto error_irq;

We really only need to do this in case of an error.

(And this patch needs to go to stable trees as well.)

Thanks
-boris
