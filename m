Return-Path: <kernel-hardening-return-12499-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvhvH+Mztc6QphvNtPvVxUUT8C51PR+3jlb0aR65Sfv2ak/YTog2ucP4sdeqa5hMTeSp84f
ARC-Seal: i=1; a=rsa-sha256; t=1520931335; cv=none;
        d=google.com; s=arc-20160816;
        b=CB/h6zIgy4WYC0XOQT5yT+MCK0h1VtooXNIV8FctmA9Gs4jUlmCVMqWeOzvM5kbheG
         gGdVVGYlBOl2jmypOyCyqg49k0WXcip5YSntwHerysmnr/An/mXyCZg1xILCHtncLowY
         aiytHh9x84cCki24JlESkItfzbTyHnmokhzHSf1HZm8iYTw2m/748zZAqR0W/v2aX4nP
         /xPBeyymAfxaniRVrYYwusQVssCxwiUlN8DwDM1MRoEX1I5Xiq5ULe5ps5hiK8GZUH0v
         aYpYWugT10v+kKE2kM9d/Z8wqcXm6sXov+nEIerXkD/81Wruc8LYHVKdL83NDj0ZIlxq
         BH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=+Q1HSk86WthizWhv6PLf1WBHHLhbqU8Y2R2qWkc3rL8=;
        b=TVsn1IHIyclgTL+17Svxt94FgZkaNJZPbc0tmdqVv+TBJbc+nA9jzhXx+r83s97gRE
         JESj9iXoxNo/X13ZYHZPjvARHyWJijkW3F2frIwDPbwpoiU9Z3R96/HeqA8GFfr8xqtu
         EkYvoV55xKv8Mm4Sm0XIPmeUPAK6m2uOgLwF3QYnRqOsP7sRafj7swo4lyaRlnGqhtwf
         ImeOsnFSQivu+D4EA9PZJr/iAwez5TXTOVwQJmRzNQamTy5dR6VW7CYSyAJDzFj0j7qR
         fC9XiV6Ox0+JCvcTgXhGgViDWh15EMJ2CH8js2ASSIQT781GNA/WgaC/WQTR+LaK8pCU
         FiHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PfOAemIZ;
       spf=pass (google.com: domain of kernel-hardening-return-12499-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12499-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PfOAemIZ;
       spf=pass (google.com: domain of kernel-hardening-return-12499-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12499-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Tobin C. Harding" <tobin@apporbit.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dario Ballabio <ballabio_dario@emc.com>,
        Kees Cook <keescook@chromium.org>, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
	<20180312030834.GC8631@eros>
	<CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
Date: Mon, 12 Mar 2018 22:35:36 -0400
In-Reply-To: <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 12 Mar 2018 11:45:53 -0700")
Message-ID: <yq1y3iwem87.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=654
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130031
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594812095867054014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Linus,

> That said, I wonder if the solution to this particular driver is
> "delete it". Because the hardware is truly ancient and nobody sane
> would use it any more.

I'm not aware of anybody actively using these anymore. They are
mid-nineties vintage with an M68K processor onboard. I ran a couple of
these when they were new but haven't had a working board in probably a
decade.

No objections to Salvatore's patch but I have a slight affinity for
retiring unused code over patching it. So unless there are objections...

-- 
Martin K. Petersen	Oracle Linux Engineering
