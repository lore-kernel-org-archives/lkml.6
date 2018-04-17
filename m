Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx48/5QA0xpgB1PzqFsjrkJe0ZUjVyXfG6VMDlMXQpaiLBUeZz13/FoQI5vi3oYOCPY6Wzc8S
ARC-Seal: i=1; a=rsa-sha256; t=1523936730; cv=none;
        d=google.com; s=arc-20160816;
        b=ejw/gEyCNgxIbuWSxN6W01AtqjxkyCdk6UvwBClXyFwUMjjjz7JjpmWJJUH+M95gUq
         5C2knBZc4UeuRuInq7T4pdlAVIQMtOvj4lr2Hjnwa+14Ab1OZ6waWwX+RDTcR7F1KYlE
         azxCjlCV+SoHqEjaAUTicCtKJIaVewdlxfepD6ERn9NIRfCV1z9N+XLFfHxh1eQqLABJ
         CDzECgBB5JtQSwfhAR04XCZxYNP8pNMfCnJBt7xWnU6+IoKHsjwGED4KhdIXDG/OJ+y1
         +5zZOPRBrIrzjAAajhJ4dkVyGnPUKYPNDLme4hMRNozbGMpnMBneU+MJkR8JZr759k9P
         E32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=MAkfVYP1XX9aNzkFNaWXEKEVzKMW1G1K4ZHt+GsgWkw=;
        b=Lns6jFOb/7O0ELepNo/mOfJznQZs/wzSPW6k4p9NDhVoBI5thvgM9xrdAUQTR/zi37
         84tOnQSbm0y6+82nACAY2ALjbSau/ZBR9W2/UDI6b/IqsNX/6H/yJsN513l/mlWG2A0O
         0GtLEiaRzNdEB+uuJeFEK93wa/kaSbUX0BF14LDkR6+gEaYVTmqw4zU6gprLKrSrzYk9
         9yuK2Mdd43z4kfg07QCWp5AuRkTtAoGfqWiBT2FXY0lvZYmO+Gt+BgTOhx1iVcPfg5Qx
         TLz1qcSWIjok3p/j25X7gEnZf8CxE6Gr90/kQ9QqYv+RBZKZNa1sNwH3KvBYsQx7vrk9
         vHKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 7/7] ocxl: Document new OCXL IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-8-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 13:45:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020950.21446-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041703-0044-0000-0000-00000548FDEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041703-0045-0000-0000-000028890909
Message-Id: <ad475a7c-68dc-899b-28ec-8d4619e18105@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1597963480866720661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/04/18 12:09, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   Documentation/accelerators/ocxl.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index ddcc58d01cfb..144595a80a1c 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,6 +157,16 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
>   
> +OCXL_IOCTL_ENABLE_P9_WAIT:
> +
> +  Allows the AFU to wake a userspace thread executing 'wait'. Returns
> +  information to userspace to allow it to configure the AFU.

Note that this is only available on POWER9.

> +
> +OCXL_IOCTL_GET_PLATFORM:
> +
> +  Notifies userspace as to the platform the kernel believes we are on,
> +  which may differ from what userspace believes. Also reports on which CPU
> +  features which are usable from userspace.

The first sentence here doesn't seem to relate to anything that 
GET_PLATFORM actually does - afaict you're just passing flags which I 
suppose imply what the correct platform is, but really they're just 
feature flags?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
