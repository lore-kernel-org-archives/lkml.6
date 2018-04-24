Return-Path: <sukadev@linux.ibm.com>
X-Google-Smtp-Source: AIpwx49bgL2XSRu7WlMQji07aRHcAIa6OOoXZnoctwdqmjj4EMtKbJPPMkRTGBGgLaoyvKZDm5Fs
ARC-Seal: i=1; a=rsa-sha256; t=1524604362; cv=none;
        d=google.com; s=arc-20160816;
        b=MsGWfXsgoSlyus8hWJom1WgKXBIeTZph7Y41ZSwQhJbZcykP4Yzqm3+5em7zB34Op2
         qQnd5eY3hn6qXEtd0OOFWlUBPzc/xRqwaQbmZDaHuHBKyTuuU1cDsRSS6WI2NJYlGlNo
         IDKXrwqs3sB1hYgeGvcNpXiaKSyA6b5XIqKdnTJr2bokQzH2mUj26DWOelE/L8O9fVCM
         Ol5seD0NpyXbBEgOxNGyywjdYqpZ3mo9blOIq8lNEUvLA+DKGsV5Sd4k1v83WiSbliNC
         ZKE6NCoUoIrpQAwIU3DxF6fs4C7L50uZDkerkimhQTFmZlBeBc3A3qeej7GoUMhAUJ19
         0CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:user-agent:in-reply-to:content-disposition:mime-version
         :references:subject:cc:to:from:date:arc-authentication-results;
        bh=aNarhUiPM6Nw08Fljy2jCptgUnzYDjuYXMO5Rbj9vRg=;
        b=LINJZVKZIOOG/7gAmOEJJGgbA6kewOsEyP3JspJxMOCUclFGGuy+2iOMGefu1BGA5W
         8ysTvPihSVlWkPcR6kT3yk70bvdYMsJZcb7HdvTvRZr3VttY6frFIWTo1lxHjbJgJmGj
         PCVwuovDEDkj037oxNpfTMt+1Jj44aR6BRXts7jB9qwuWNp+CAb3oJgVcWNXnSPOyaP/
         6lLIwcah76QnU7kq7wykTPwyFPeVc3bSGAB9pO/ZJnt5nFNVlRF0yYbA7jSjhtxebTSK
         KJA0U1nr/9tvbgoUXiJKOG4whPKDAEilTGLebZjI/BxJehh5ER4zBtSGQBWu3Vfmuj2N
         dBEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sukadev@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=sukadev@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sukadev@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=sukadev@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Date: Tue, 24 Apr 2018 14:12:32 -0700
From: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
 <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18042421-0028-0000-0000-0000097EEB58
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008915; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022740; UDB=6.00522045; IPR=6.00801975;
 MB=3.00020756; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-24 21:12:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042421-0029-0000-0000-00003A83EF87
Message-Id: <20180424211231.GA25392@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240200
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550726280592?=
X-GMAIL-MSGID: =?utf-8?q?1598663543533804912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andrew Donnellan [andrew.donnellan@au1.ibm.com] wrote:
> [+ Sukadev, Christophe]
> 
> On 18/04/18 11:08, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The current implementation of TID allocation, using a global IDR, may
> > result in an errant process starving the system of available TIDs.
> > Instead, use task_pid_nr(), as mentioned by the original author. The
> > scenario described which prevented it's use is not applicable, as
> > set_thread_tidr can only be called after the task struct has been
> > populated.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> So it's too late in the evening for me to completely get my head around
> what's going on here enough to give my Reviewed-by:, but my current thinking
> is:
> 
> - In the first version of the patch to add TIDR support
> (https://patchwork.ozlabs.org/patch/799494/), it was originally proposed to
> call assign_thread_id() (as it was then called) from copy_thread()
> 
> - The comment block documents the reason why we can't use task_pid_nr() but
> assumes that we're trying to assign a TIDR from within copy_thread()
> 
> - The final patch that was accepted
> (https://patchwork.ozlabs.org/patch/835552/,
> ec233ede4c8654894610ea54f4dae7adc954ac62) instead sets the TIDR to 0 from
> copy_thread(), so the original reasoning regarding not using task_pid_nr()
> within copy_thread() is no longer applicable.
> 
> Sukadev: does this sound right?

Yes. Like with PIDR, was trying to assign TIDR initially to all threads.
But since only a subset of threads need/use TIDR, we can assign the
value later (when set_thread_tidr() is called). So we should be able to
use task_pid_nr() then.

Sukadev
