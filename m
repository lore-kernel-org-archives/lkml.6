Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpCbhtTnpNeZw5IJ8IINgsmMWfh4FEk8+UQJNXjX+kIS+9wfbqeBS46sUThh1EijD8zR2Oa
ARC-Seal: i=1; a=rsa-sha256; t=1524035041; cv=none;
        d=google.com; s=arc-20160816;
        b=wRLzOxIBmw5AE8CHPvZTB9HhYejD24/YLi887z3UMkARxy9IJsBRdV7vby4nWtsyoN
         HHcf5tVLvFKVuBN/3O2GElEcd7R2ycOXnOe+O/oNW1ofhmqj/r2J2mWhzcklYKrm5Lcm
         3l1M2PEyWoFNygH5m7/Y+85X3ZUX2pK2n+0b84kOxavKsq32UYGlmtnc/ina/VIPh5vA
         WUjTjEDUsDw4woVc3+773NG2GMkO7B5EVHgWVRPepPNpmuMPlSgDgj8ys3EVMk05CP26
         7IPodw0SSWj8GAqXYEPpleU+myqpwHV5iGmkY2K3W8zN2w2AMxjjszf1jzLr35Gpusln
         pimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fIF0Cw2krGi8USz7vrXBlDPwwjSdTTag9TsnqRETEow=;
        b=p0tc3z6+OwMoeZhoU0Oy6lnR++gO6LL5kigE+hN1faJzm7p/4C1yMUjm3cmZji2rpW
         LUmQVeulwmK5RHGtP4K9eht3j1TJg8CIDrU5NOuLYU9RzyB0/ff8Dqr6Neo9KoNuOuOF
         YQtA8iMzinM9VF+NUePUNFANoqomUrHuYVJeyyvElgKrmiyRgmC55uqxbcICCaOkVvFV
         7Ih+0AfK3LdldyofzOKmO6nFVQv65FvOIb/zRhUkmNpGBsYhciXg2oVhGzW0BB6rfayk
         aQHu1ZwPyQgx23milpL/oUGjni7tX+8DQ8bH8KlniCayWXnSn6drI33bpN21b1vpC1ii
         1f8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-2-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 18 Apr 2018 17:03:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041807-0040-0000-0000-0000044EC984
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041807-0041-0000-0000-000020F3162D
Message-Id: <9557d29f-49ca-c735-3630-df12b0415f7b@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180065
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1598066567774175432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch adds a CPU feature bit to show whether the CPU has
> the TIDR register available, enabling as_notify/wait in userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Per my previous email:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
