Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeEPSPM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:15:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeEPSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:15:11 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180516180115.GF25661@ziepe.ca>
Date: Wed, 16 May 2018 20:14:50 +0200
Cc: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hal Rosenstock <hal@dev.mellanox.co.il>
Message-Id: <FDEBA43A-C98F-4E2B-A8F3-CA809FBAD479@oracle.com>
References: <3bee76df-49a6-cf3c-6df4-749a6309358e@dev.mellanox.co.il>
 <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
 <20180514210200.GN21531@ziepe.ca>
 <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
 <E41BCEAA-0204-448D-8188-ACA03932B3AC@oracle.com>
 <20180515190424.GL5615@ziepe.ca>
 <3E15B62F-E705-43BD-8A72-9E74F784D40E@oracle.com>
 <20180516151201.GA25661@ziepe.ca>
 <695ae613-931a-50ba-2b83-9d172e0ac2bc@dev.mellanox.co.il>
 <151B2A36-28F0-4A88-8633-31AE7E55F848@oracle.com>
 <20180516180115.GF25661@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=646
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160179
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GIFIra026025



> On 16 May 2018, at 20:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Wed, May 16, 2018 at 07:46:10PM +0200, Håkon Bugge wrote:
> 
>>   OK. Lets take one example. The pkey table contains 0xFFFF, 0x8001,
>>   0x0001.
>> 
>>   The wce.pkey_index is 1 (i.e., pointing to 0x8001). Now, tell me, was
>>   BTH.PKey 0x8001 (matches 0x8001) or was it 0x0001 (also matching
>>   0x8001) ?
> 
> As far as the Linux core is concerned, it must have been 0x8001,
> because the only way the pkey_index feature works properly is if
> exact-match takes precedence over in-exact match.

And now if the table only contains 0xFFFF, 0x8001, how do you tell?


Håkon
