Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZrcxN76TKM6rmjG91rjH82Ire/veOdWpBGsWVNj2WLRKb6xRqNL8HNG02O+gXzPkcaUnupu
ARC-Seal: i=1; a=rsa-sha256; t=1524209124; cv=none;
        d=google.com; s=arc-20160816;
        b=eKH0+0nUfTzbNGcTXaZNErjMVgPLP5EILRMZg5g0B/hozZ5vbZG3hn1nsg/Rmfa3FI
         47Tnaivn7CgolnOt/g0xURj2yaJn7RqCXxBtgA9ApvAyzwHmXveUzL8QgVJxZmgP0o4g
         mnyyvtPeWu+jqFRmGpBDJ7ZLYjbn8znljFkDmpijg7AQZsFZnpRjBL2JHgMukFTPStPf
         mZV7et08ncjk7wyryqzbMvdigx5M3ok42PTQ8T7SUiXqrCWXYcVTh2axdKSLgbUH4arj
         5mS6MI7OR9knJtCQ6KAHlgmPr9yygr7f+wCJ4wf3FGjCjkUATk19uvET7Zl1K3IXpLDz
         ta3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=yX8DGmScmQFlAZ09+Xm0IUO1s2Et0xLxLvu1zr2wHT0=;
        b=PY0VvO5DrbVjJ4IYuy0oVTybktLoSocXy6KZTUJIi1x1w9rihk3/3bHQDu/mQhbqqn
         EPbhygY88X73cykTvW8G8s2OmP+BzsHk1zZePw1LROQGasc16yUl/WzDSpSa8oy+RZs1
         qRtZU80G8QkH+uJ5pa9z98gRNSvA6bWCrNgxVZkSm5Z1J6pSU0fXnA51rsqqnLa3M2Oi
         HQ5hEE5L1fehI1HPI0yu2IXLyxMpxh6j0BJetYl2iiomuMY7sB4U9stE9D25zmWfVUiC
         cEOvEXU1kMkuLSNDtBQF97Xl26gYpmYmAmhM6mguZSO3Z7+3W/f3LCp4J23s0WkkRKDH
         UBRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-7-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 20 Apr 2018 17:25:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042007-0012-0000-0000-000005CCE6C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042007-0013-0000-0000-000019494342
Message-Id: <c846eecc-6044-c50a-35e9-a79d803a509c@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200075
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1598249106288130607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order for a userspace AFU driver to call the Power9 specific
> OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> make that call.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Looks good to me

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   Documentation/accelerators/ocxl.rst |  1 -
>   drivers/misc/ocxl/file.c            | 25 +++++++++++++++++++++++++
>   include/uapi/misc/ocxl.h            |  4 ++++
>   3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index ddcc58d01cfb..7904adcc07fd 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
>   
> -

This is stray


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
