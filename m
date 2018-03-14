Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1140530-1521016340-2-1760264902758651862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521016339; b=jW6D/7psdbNHrRiAStcSID0EyDiQdDOgte8KtW3urTtslXf
    ajmm0AM78QK1PWxNRmojoTRxRO2ClS9GCtUk6RBOq8ZWV3YFrM1wv58JW9iT7S0c
    Ydxy7Ug2nMyhUsn3mvRA0CZESn2aylXz6VnJWWQ/08M73Q8JWu7hOXpCskGTtQOo
    0ynN1VmkmbQOkTDvh7NeFmmz0MqnR2yvjNjNM070n5YThCTKO7icnzd3LUoeSDUw
    IdUeccgs6nboXGIGYDy1kKxCNML8cdxzgPRAWjNoGS+7VVzSQNfdRGDCVt+Mr36O
    W0X0FKJSMyHL/L5sq3kzXzU05Ald5Yzon2PeWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521016339; bh=x
    M46WNrLSUEewpYfjAv14IxHbTT3Gr1f1vr18HqeJdI=; b=uw+p/lhi7mLqzpJ5E
    FbnjErauiSIvAFHOL0j0KjWRjOzmECFKKiPJBdnhldZmWxwo8BIozILUVoFdvFic
    Mlq0JbSYi1XFYyasQT8NRUa/0W5Shf/gj8U8Sz5PAG/NyWA8+pacqscElAGDqBYW
    EFuR1aAfZGPnTofwIqMzJx6NsgBQ2INdccVu7jG+yBEtZGeFQsgeGW7pNuIJw2zk
    TL1tqMCl4vMQrvCviGCHtKNSC1j5+QmKUBskpeZ5iz+IKJ0jNvmdRGNgpTZSbep4
    1XDV+wthgkPjP75u2TgyQ0MSzfTQQ1rAyydnG+tma9xzwLQZLsVd7HURrPLxGAc4
    tJQlA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZFdOGIrO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZFdOGIrO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 11:27:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Mohammed Gamal <mgamal@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Message-ID: <20180314082701.2inzz2etg67r3zry@mwanda>
References: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140100
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
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 08:06:50PM +0100, Mohammed Gamal wrote:
> @@ -791,6 +791,7 @@ static inline int netvsc_send_pkt(
>  				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	}
>  
> +	ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
>  	if (ret == 0) {
>  		atomic_inc_return(&nvchan->queue_sends);
>  

Could you move the assignment inside the "ret == 0" path closer to where
it's used?

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
