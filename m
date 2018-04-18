Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZrZKbJP21P3Q4CweA76w4202v0Az0ou/wnPUEycjoIjt5UrGeTnmdVysQpnHHD/mdnxZz5i
ARC-Seal: i=1; a=rsa-sha256; t=1524036592; cv=none;
        d=google.com; s=arc-20160816;
        b=CIbTIo+BOVCSraLWWRvQ74RWNrq4i+pPK1pljdWn/Rrl2kqJb/UXH1H3fRgO/j/9vf
         m0EHmEucbXsBgb7KZ31vXAP0h/h195xUZADkhK7y5xJ4lvj2V1AsaPMJl/hXEjXpeVN5
         Vj64qTEGmDxHLLXzCOTdwZPvFMFB2/ukA0hB55JEEM3cSjSBtfUceTLUACdFLbTaewpt
         AApogj4R4c9xpk7bAPlpQGa8H4qyI5IIqBaa3S+Lo6lHKM8ohSLWiKzAHNHPHzN4OmFC
         uN9eIyMUgm+5EGOEKZb/jzab7Q6njGvyKZJrnpn14AsTBQwlyhoJnDrOPLfFzLeLw+tp
         YXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RzmZ/uUZJ67RoerZ8On777X8oppdd5EHEjgSrPBuoCw=;
        b=nUe4JBzD1aJBG8kLR8mSBvx5q2FYSxfFc9w1VzcVmQX7IxWrzW8mObnfUsOlriuT5n
         2gp339Wvl5/seVB91Lkb0igROPnGbnbs+CTctfJBnZ+BQVPHDe21sYP5GZiFcofuxTHG
         W72vZ3MPEoa+686iWTOV/fehUCg8rFcV4uaLS4dF+w3AE8VZZBsCEbjZO5Hv3o6Zm7dz
         LvihAYxx2iKiwYKlXPA2gFb8mqgfn9qJ2eSomIaQj22umgEW3y6NkSm/CQ8udI1pV9Rw
         jhSPfhbm/V7Nn81b4jmJ2CRWJBdus1b0+BlFdbBLCOPsqqnkGf+5VrKRTVCS02AG7J1F
         /nOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 7/7] ocxl: Document new OCXL IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-8-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 18 Apr 2018 17:29:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041807-0012-0000-0000-000005CC1AA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041807-0013-0000-0000-0000194869F5
Message-Id: <8b0bdcc7-4c0a-4ef2-38b9-55b3c8cc3035@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180070
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1598068193890900246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

This looks better.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   Documentation/accelerators/ocxl.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 7904adcc07fd..3b8d3b99795c 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
>   
> +OCXL_IOCTL_ENABLE_P9_WAIT:
> +
> +  Allows the AFU to wake a userspace thread executing 'wait'. Returns
> +  information to userspace to allow it to configure the AFU. Note that
> +  this is only available on Power 9.

Nitpicking time, if you do a v3 you should stay on brand and call it 
POWER9. :D

> +
> +OCXL_IOCTL_GET_FEATURES:
> +
> +  Reports on which CPU features that affect OpenCAPI are usable from
> +  userspace.
> +
>   mmap
>   ----
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
