Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx489ojFQm5hr5TyHfFcp8/7JJ9yE0JvorE5+Qnpdl2EaeQ4e+rGpFDntXYGcywui8DXcpdA/
ARC-Seal: i=1; a=rsa-sha256; t=1523943079; cv=none;
        d=google.com; s=arc-20160816;
        b=EgZm/YtSHgBcWX8tifhDJ+VshGt9opBr66WcWMQTZ0kCWtVtgCkys4mujpBz0GqguM
         vgU6ZKnT0AMrBWegf7G3GhcmBBtw289Vi4IOegDsT365IX1frXHpfdzfnmhWnyUKaX0P
         40dO+ScIQhlGXvabb8O+OSHro0+z7G386COjmB+tmmMvj6uxGiB99SZ5DvcmWOC2tiOQ
         3+Y61wMSeXsDqqjONLKG+73wiw7K7c7s/L+8qLQqhE2JGidT0Z4afxWqINKJ2MKK+vQM
         6hI3dux74lnFki70zz8Y76YjNa8hDiSA1k/P3FVJ2vOk+30KMRusSgFHeyN43mYYwXoJ
         Ku1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=3QyngbaqOa8nXNCJqcgSA355hCrfkTOok8ougHzMtbE=;
        b=iQEGmty5cGvQdtE8e4d3t/RTZP9U/AzKtyRRjEvrtgLbxREQm7g+1T/CS4uCSnQw7r
         lAKQmSEYoat8yLoTk38vMkadQa7WmD0xrSLx4Mr6QSFPxlwC0PL7twxnGeN1ATQGiHaU
         QIyTtkClmSi2pDPwcwagHB4yTGWC+Jm1ckyBmiaw44nl82GUwPSpTqv9zPI5uvzfviHg
         2He2WThNsMPW2JZkLm1odrX7JA521w85FtkW6y6kRySu1OJTScbhHhsVHofAcjDHrxKD
         L3WPxKFcYFS/Bs0k1cSik/p92ooYaWR7mtWD1ssh4GyV07WD4wVr9/3y8xPMD7Sko5d7
         aDXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net
Date: Tue, 17 Apr 2018 15:31:08 +1000
In-Reply-To: <89476138-a279-761a-21be-4a7cd1d80167@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	 <20180417020950.21446-3-alastair@au1.ibm.com>
	 <89476138-a279-761a-21be-4a7cd1d80167@au1.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041705-0044-0000-0000-000005490660
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041705-0045-0000-0000-0000288911E4
Message-Id: <1523943068.3246.3.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170049
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1597970138522335513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 14:21 +1000, Andrew Donnellan wrote:
> On 17/04/18 12:09, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Switch the use of TIDR on it's CPU feature, rather than assuming it
> > is available based on architecture.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> There's a use of TIDR in restore_sprs() that's behind the ARCH_300
> flag 
> as well, ideally it should never trigger in the !P9_TIDR case, but
> you 
> might want to update that too for clarity?
> 

Thanks for the review, I'll include your suggestions in the next set.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
