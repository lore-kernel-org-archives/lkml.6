Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2350961-1524253223-2-1917030374488198858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524253223; b=uM+GFz6XV/rP+l9nINsA/T6PoIvc2Z/T+TCPc9idNDfsFbnva/
    pU7N0xSCAf2NrUfnOKHIbJw41GdIeV7+JNZ8zRWSzNlMfrIQZfp2PkIjTTAHTaDK
    8ZT2b1vSBNZaMHA+wntdQzyanFBy9pfzwd93KNYBia5MEazcuq/HgVeg6g6G+WCM
    Rvb5R9SbhOws8d60eL9OMEFYqCQcRjl0xJcEzOTwmx4Udfm5t7uRVt9qkgybET97
    HR1likrMnfKwC3hWAyxTp2sd51h+BBtMkwkFuB/JcMKUAY0WuB9u5+gae1hQvaDD
    xTAfSqjgxWn3BjFpPlxcRgl2BBHnNySqjAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:subject:from:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524253223; bh=IR2UQ
    RfF2VFzih5h9NVhUYZ0ppWToE9Qs+KLEM697OU=; b=wtyyVbiHncz27r6iBnxxO
    HVGG4Zp7xBXUFiRGK2r6mv/9zVQ2eHGdynvNh8Nt1mdla6WT+S/sa/uxPj9am6u8
    +dNysem2LoLGk64zvkiPt2EDRv/o+BTIsV22krdiSzUZSO1jOQ49+Wr463Vk5G+L
    grJPd32IqgFZbj7/cw/FPP29/bVTxSrudCn9TOsRBW/5t6lVtH1vY4ZecjzATnfm
    kT3wFdVNUkSGb1ZFe3imAD1IjN4gXtGIhUDt0GlcMnM6y0FDCaIomLfkO8UCFotG
    GnNNfaaOu9CSPe6KHc70B98OiGjrYwI6RHdSQp51cDcN8Y7Uae9BMjunnHwwsRq5
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=CEpep6IC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=CEpep6IC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOXCVZ/spp8lBkMt3gG8WWnQT0T2JmXf89/6aPwXPyK0SAxKqym/GEjALc/hTeqtrmbIJlyGhOsx35gOC/vJGxFjft4lpdIiOpopvCO9hEMNcOLfKOBV
    YAtVVzfUTM84WszdIsXF+p+ps1VBPnTAY7U9so5a6QlgMT27FuKIRP4YJ8G1VmQEzp75+GNEQJSzu54BEMWoYyoVYVqYJOYaR3lOjy6dxqq+RHCKufbrlMVc
    rCt9ALG9zUTFWFMumUwBRw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=VYWjqLN-Pp2YSsUAYW4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
To: Long Li <longli@linuxonhyperv.com>
Subject: Re: [Patch v2] Storvsc: Select channel based on available percentage
 of ring buffer to write
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180419215424.3557-1-longli@linuxonhyperv.com>
Date: Fri, 20 Apr 2018 15:40:11 -0400
In-Reply-To: <20180419215424.3557-1-longli@linuxonhyperv.com> (Long Li's
 message of "Thu, 19 Apr 2018 14:54:24 -0700")
Message-ID: <yq1bmedis4k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=275
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200197
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Long,

> This is a best effort for estimating on how busy the ring buffer is
> for that channel, based on available buffer to write in percentage. It
> is still possible that at the time of actual ring buffer write, the
> space may not be available due to other processes may be writing at
> the time.
>
> Selecting a channel based on how full it is can reduce the possibility
> that a ring buffer write will fail, and avoid the situation a channel
> is over busy.
>
> Now it's possible that storvsc can use a smaller ring buffer size
> (e.g. 40k bytes) to take advantage of cache locality.

Applied to 4.18/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
