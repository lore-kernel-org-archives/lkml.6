Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2398620-1525145111-2-9119409014139808879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525145111; b=SOC+iUrBF4SqIAWu/Pyi9S6ZhpbYdk1TbNE2CEYY/SS5sscKpz
    C988fYzPCj/8wtEogucwxYIMYtYaSpep+utJui46HPuLicJ5vIP6s0KfUHz14sKa
    V4reIUPbvAh9wi0DtffcYgR4l3hXVX8uDBF2JmOsqZTGPbRtLduC6VCPEOLTG+7V
    ovDIY2S2QZ0Swqoaeu7RwiItY9fgzjgyjSavsXHMr2dM2wtBTvSnBJuupAv7XQqk
    wwCZNymniaHjdISNkPydQtp9vKYhA2aPhuIttdIOgl1pcD0giNSV9qPNdB3dYYPw
    I/7Slq62ootzOW7kS2FvPVl+1nm+PhFbNqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1525145111; bh=NA9cUXIc29pmZlPGLg/n5qlOjV9xLq
    9Tx/yXT1B8WEA=; b=hqqKAk89ZVv0tZzqLFib4SJDlgHSDxjEWFjarZlwlXBz/6
    +WQaYvZygoLiJm4vXJKoBaeRC9Y+FAOJPgMhyx2Q7crwvlZZvw5jl2TRjME0c6oj
    nT9Mrvjvm7VHh3aopmuZIDoWuNFliheHdMeLWCEzWeU0t+8TAT3Eouoxec8wQlnl
    Y8bjWcqyFOfupC+4KQVC0RUdpxt7k9mR7vxin0pQ4iFbAzKhLdd+TNsvOmF4RsC+
    EOSVW29DQdmuFOil51Y+nMZZ5hBJ6LQcu0+bxcMCoU5ISVv/Zda6O6ZiOhpIRAet
    5LQhE3jDXmRYyYYqnXiNw5nMoAorAHlxH3Q/Eh7Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=QOqCMkr8 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=QOqCMkr8 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPXB1dvLd6eriOZwbtNmgifKlSf5TBlDOBP5Sf870fCDOGeOyFZ/7eOLz/aYLN664Ui6kDFhVD3LQjmCz2pDuDWAisTT+S5XjTDosYnAX5hpoNZADOVL
    HloyPl6oe9S0o6AoSfofN1qs0Suo7RWmwlBfJM7hfiQshlKGgcq/Y3nZic0of6Cvm3AujdwpQMV8SFKVzn8bn/Dk6+UUMKZaigZLPe5Aaq4WQ2KdHoMlvUc7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VVAyi8jNWOtIG9hKimoA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEADY5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 23:24:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57566 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbeEADY4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 23:24:56 -0400
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
Date: Mon, 30 Apr 2018 23:24:49 -0400
In-Reply-To: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk> (Sudip
        Mukherjee's message of "Sun, 29 Apr 2018 17:01:38 +0100")
Message-ID: <yq1r2mw83cu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=379
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Sudip,

> v1: Only M500IT MU01 was blacklisted.
>
> v2: Whitelist M500IT BG02 and M500DC and then blacklist all other Micron. 

I think my preference would be to blacklist M500IT with the MU01
firmware (which Micron said was affected) and rely on the "Micron*"
fallthrough further down for the rest.

I have not gotten firm confirmation on ZRAT behavior so for now we
should probably just do:

+ { "Micron_M500IT_*", "MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

-- 
Martin K. Petersen	Oracle Linux Engineering
