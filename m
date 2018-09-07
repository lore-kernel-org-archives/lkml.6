Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dqT/IkJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIGL4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:56:22 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:23212
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbeIGL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNYNA/ehBI8YY2h7IvJLBy5WBPuWgzscb6IVQZ9RKCI=;
 b=dqT/IkJzibQ9v7cKpYAIRII6Kz0k6H7Et4MFNq77FuTzr1Uu9PJrlYD+0bjT3e6rCsJsFPaq1qDbcQTtunjUgk70U7vy5VhZYIJhvUv83ZOp6zWzbff6b3W/c1HQB3U6panpLZ5kdE2shexBHsmhcP8RV+Tg/5tVVv1p4ycl+8w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.131.27] (202.56.249.162) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 07:16:41 +0000
Subject: Re: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
To:     Sasha Levin <Alexander.Levin@microsoft.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-43-alexander.levin@microsoft.com>
 <20180903111626.GC10302@sirena.org.uk> <20180907002313.GB16300@sasha-vm>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <056779f2-8b3b-63b5-ce0b-f314317156f7@amd.com>
Date:   Fri, 7 Sep 2018 12:46:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907002313.GB16300@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::13) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a2b532-01df-45c9-f57b-08d61491dd1b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:KUYZf8+r88nkrA+JmfWZEhNNAhhBIJuj1vEeM4cmYL3Q+XpTUDPDwywkG0vq9TfSoHCAxwTN9rjdqxHz5ashaYGJRnxzWeHyGZsUtQJfkeQ3jN6nJjBX1yQ4rT01qujxbKuUP0tehLUo79Lxn3LFQgNXChdqSC29uui08uG++DbXmUjFxvIoJeQr474EKj+yMRo9Bn9feB+qmq12Ohd4D9ue9OBhBlLcck06jQa6NXcfNDtRq+B2NFXJRvfbo/EQ;25:rLdE1OQ8F4MUNQB5Z9ZVoL3VZVeLStBSy7G523NqnyRjlImcaARJ0GaPO3N2uR0zg1c+JJPFFHzxLMLIa0Yh/l87IVQhLfcH+ytHXPxSLoJKcR3pl31zQkm45TK2DQi3IFPeN783PMNVW+E2jd+q0LHYQtI7rQKwV0mN3TfQmvGms9gB7Zh7FMoWWZ1OxdGLakW1LuoYRj3WDdyWwI24cDJjoq4zWTCQ/lJ9jGShj+fQiS629qnDNf82s/A/By7CslZQ8bzVRGOQBQEnQDZs8PeqgI5u/sF9YQ7Zr7FFQTaoIbWvvTj4iYqlKN6Ih37fyDpU9GBGcw5BaPz9ZXvrxQ==;31:vCie3wyAjtdX8r79F5fxnN9R+UP10JcU80AC+QWr158CVCZpGHxLRDrCPaTRtSfGoZo5ifLG5NL297SRNqDrxB61u+ID+x+uOTthHrVnmIUwpb9U5TBRBeJnNtgX3AbjDCoYvwMfoSJ8Tva3dUK7bCdU+lrosqE5DAFPdSef+UTudDecapdIZluyoueyEEI4SgnUuUU0n7rGMpNF6ph1fym3X/JlLbH6SRIyIXTfajM=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:pF2eY1Q7O9vKCTnjeWUAkqq+y1NZuWrmLkY/XhKrXZqkkKa+Aq1pzW0746gzEpWxlcDy+A+2sZHej4rXuMWibUYTNKrMHODBce18Mqopa+Xge77tI2uk2zhd2QO8wkygou+ZI/tur//ZaHiPuSB+X0iMmh8a8BBHVlYsDU30EW1Z9prYQRe6EXWvq41RDL9yY7zeRyzdsUwZewc9yUApZEXQaQcN8m48Qhm8IjVBAb/8rW+/6n4NY5ki740xViNp2VmQDQqtKgoEe+7mleEZniF0iR7h7TL1KzxW4gGgknoCZVUrOXDlrxYQ9T7ur8BQ5QbtO2zNjg82xXJZskXG2oJEhJDWqx7PdGKQ3QPr/PvJN8tgd8nzxXJrWo0SWy2D6P7LUHZIT8Pwm2z1TjS0cRQigr3PXqcj4B15bcCLfIWBmSCGvObRTLrTKkRIaXJS0VzzjorzTaRvqnf1LsI3XjZrnR+Cts4IJZIOZjAK0S88tnoI4x5jbzaiSWQpkcZe;4:qWz79QbTLf2YwNcF9BoYY4rNS6AcYh8kXr7Jy1L5OzSQorPhOPkR5CGc5PLlPUbUZzXxKyyv4YCcyyVaTTIi5Wg9SDlmA2N2UxX61Rl0witW8GcR/wGSv3smbPVuVc5LQg0wg41T8+8VPsWadTBDNuKCIVlvIhI3Fi6fsqKX0P8Vl8dKbKa9ntCNXV83hhsqzcZquO9ilta5NvOwYKLAeZoX1vi6QwzRxuN2fattj/MUdk3g5Q2GZCSQ0WAbWvSBVxdekLgMCzrsv+IgxGD92dgTG8XBAqOlca64xpAEpj6wpbf31/uXriXit7J6HcS7
X-Microsoft-Antispam-PRVS: <DM5PR12MB23596553DFCB36415D976633F8000@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(31686004)(36756003)(217873002)(6116002)(3846002)(68736007)(97736004)(2486003)(2906002)(86362001)(14444005)(229853002)(23676004)(52146003)(6486002)(53936002)(105586002)(31696002)(486006)(8936002)(230700001)(106356001)(81156014)(81166006)(11346002)(2616005)(50466002)(956004)(446003)(64126003)(316002)(16526019)(16576012)(52116002)(386003)(72206003)(7736002)(58126008)(305945005)(110136005)(186003)(53546011)(54906003)(6666003)(476003)(6246003)(1511001)(76176011)(47776003)(25786009)(3260700006)(65806001)(65826007)(8676002)(5660300001)(65956001)(66066001)(4326008)(77096007)(93886005)(26005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:[10.136.131.27];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU5OzIzOjRERUZkWDFtOHYraUtKempxeWVSQ2pZVTQw?=
 =?utf-8?B?VTB5NFpwZ01lRk96dXZ2dmlYenA3VkdoYVl5SFRXVVp4ME9UVXFNYTB5eitB?=
 =?utf-8?B?QnlOTlNEcUpYRVFCblhxMytKSGQ5RzF4azBmRFhid21xekhkT3MyMm9RamxP?=
 =?utf-8?B?L0FFN2E0OXFZS3Rob015czEzSE5oeUl6dTJVMkFtbkJGaTVTZE5KNmZiRVhW?=
 =?utf-8?B?ODhIeGQyZnJmVzFCd2JQQW5QS002NHFFY01jSWlXa3lBdkNmd0tlTlAvS0t0?=
 =?utf-8?B?ZFlZVGxuVmVwNEI1TzYwTXQ5aEdxQmRpR2w4SGJZcGRzdTJ5bW5oeEdzYUcv?=
 =?utf-8?B?MURDY0hJb0ducGJ3MDMwNU91d24vVjljM3RxK2lHdDFtUFE1RENTQlRTYTNU?=
 =?utf-8?B?WGdEd1o2N1dQRWdZS3V0Q1JocDZseE40emxGT0taUDZPTkRZNm5VTXdoUm1h?=
 =?utf-8?B?R2VlMTEvYlkwU1hnVDZuUWJQS3FZcHlUbVFZcWhvT0tUZEpaMUx0bVMwWHNo?=
 =?utf-8?B?MFlMMFlUVlRpSk1JeldYREw0eHU4Y1JMU01jU0J3UmFRbm5NS2gvQUtoRGZR?=
 =?utf-8?B?RUhub043bEVwek02dFJ0ZmpBdXhvTVRCaE9LM2wwNGRVUUZsUUlUM0JVT280?=
 =?utf-8?B?WGFPU3lNRHF3VlRLUnllbDE2NzAvbkZCS0RMbE03YVJzdGFVelV3bC85VTVY?=
 =?utf-8?B?N0g1c1RCdnBoMUdxakFheU9uR2VFMlFoWkJBbENnbXFrMFYwWlo1OGRyckR1?=
 =?utf-8?B?UVdxYkdhb1RjM3dVUmc1V21XaXplSG9oWVJiWkYvQmpYck5IWG5Na3JXQ1hY?=
 =?utf-8?B?Y2lwaDNEQkdPY2sraSt6bnMzdjFZcjJ6aHFTK3hyZjhpZEoza0pnYk9ZV2lj?=
 =?utf-8?B?YngzRmFPaWtTM3hOcUxMUGx4UTJGVVdRR20yZGZrZXlqWUtCamFFTDF2ZG1M?=
 =?utf-8?B?MGtMZFVaY0lrcXlZWmJxVzdhc1VpaGVXV2RFQW1GZkJ1enBMcmN0Zk1wTFZ5?=
 =?utf-8?B?NFdkRDhOOVpuUkhFY3FYM3BlbmNJWHpubW9XOThpV1M4SVlFY2RQV0QwMWhS?=
 =?utf-8?B?ZG4zcFdKYmxvMmJTNlBlTkpheXZRa3hRMTBRWTVYSnBkanNUYmZ6cG1ZMWFF?=
 =?utf-8?B?V1BWU044MkdHV0FBQ0hRRVRkZzZublF4dDhnL3gyQ2l1Z0FVS29kdjFzckU3?=
 =?utf-8?B?K1BZOTlRU1htK3ZWeUcxK1ZFRkRpall6L3ZuYnYxVE5zMzdiVzhIbEhHUmpq?=
 =?utf-8?B?WUZ3enlDRkExZTZJWXMweXZVdnZKdE4yZHpkOUR2K2tPZERtdkZOUzN6bVIy?=
 =?utf-8?B?TUZUaEd4RnFHRnIxRm5HVVlxeGw4ZDFwekxncXN1NDlkSmJackhKbWladEJP?=
 =?utf-8?B?anhYd0loMFZrZWlZUHdCWlhST2RqbGRZbHNYSE9wblVRdlpPcGgxUFp4WGow?=
 =?utf-8?B?RFc0SGx6eW02NVNDY041RUErZEZOVHNLWDNlR0hpd1ZRTkhGK3NSSDEycTRt?=
 =?utf-8?B?UDcya0tOUnp1d3M0VTBCU0phZ1ZtajF0enFCQnJtaTVRbHZDLzluRlRvM3k4?=
 =?utf-8?B?RTBGQVJoSzMyNnhjRDNLaXdNTUQyNmlKQTV1cHFSQnFKd1hOaWZvdkdod1h5?=
 =?utf-8?B?UGZ4UUwxcUx5QzVNOWJzcW4zU1Z5KytWTHBkd1k4R1BtUUtya0ZBcW9SeXMy?=
 =?utf-8?B?endPM3NQNXVxa0NMeFQxaFFWTDNzQVd3ckNTTHM4RVFDNG1LVUJXK1lJOXZR?=
 =?utf-8?B?VkU1czlQNlBmNnBOSDBGejR2UVY5MGk4NHJkdGFoNW9UT0YyZ3RsMzFPeTEr?=
 =?utf-8?B?dFhORUU5cndQRE12YnVPL2NWSWpIcEtTb0htMDBqcVZJNFBTcmlrVGlmTnJ4?=
 =?utf-8?B?OHRrZUhFdC9kazRPNGY4L2ZJYllOUlZWVC9wZ1FOd3lxanlYQjZLMk96UXRt?=
 =?utf-8?B?dzExSG51V2xFRCtodjh5d3RkY3Z1M3pHQzhBVUFHMGFnMUp2Z0NBZVFtZDZm?=
 =?utf-8?B?OC9oMm9hdjZZN09MVVBWR2l0QXdabG0wc3dqNnprUVpjbW1WRWErWCtoMnZO?=
 =?utf-8?B?OXk1ZEt1U1FtUzhwK2VNV0lQeks5VzVraWdQdWVYV2NXbnRId1hES3Bpdndw?=
 =?utf-8?B?ZlE9PQ==?=
X-Microsoft-Antispam-Message-Info: UJTEXHZQ7ZK9OgsgAqMGft2qEfF40gIbpyKFC+Dzf42U26vbxt8rbzWP2grstTwqwCv3gJdXvjgdOUDAacdlAypMhfgdbpvxKQgkT92tJF0GMAWEyjXWkoLO+I4C08V0/PMmNyvG2WKtD6lDjMr3DcvR6MVyAX45QSXktoFECsJ18GkKA6XLUKKZa6xJ4kz4s3ZZZpTXG9SARreNZMYuS/Mgx5gMlF0CY4GmUhZ10zweR9KrP+/N8NxcUwirGxArBfLOWyJmUkjgv4rBT0i0sfJiI0sxgE5P4oLNfxx/dSNx13ujvEFQeR27V/gLGJzXvcrAZt2DktSF/gP3uNtRuAEjzvuMl2heGvI9VRl4RK8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:R04xdxbHVuejyq/t8V7GA6/p8mZ+e2ftv/e8KigXELbCAAADvLfyBj1CzBB1JmgglozrxzVDon1I71QozmBLA4zn2QBo15+9l0QxKJcaJgmOQw9oaTgvCQ5jbVDEQUfKnoaHZHd0wBhI0HvSSgzRS7DrSjRcsIiIyD7XxpsNQNcd9w2wC4WLqk7VOR51BZgY2gW+zcSYLJcJeOBzb5RxmHEbzg8AAWgcCxhEYL6R+nRofZrVFxTn1WVdvEwcNyC01R8t+0fA7xr89iMYPpbyExZ+scvRb1WP1O+K7gDSGUEQl8HPRwF0u5P4+KruWRvNsw+2wFgoWCals4TzvoQzbInekP85g3v2civabmk2JQ5G5FVPXktvBhBm99OgwBNzMxcFnKuOOitYwrA6aP8wWkEcYCwT14labxAS/txd0vxuz8aDDS94rQSa+xbyTjFULmF6o7hSI9pfd960+bFzAw==;5:EiJe1XFvXZedT0lTMWIukKCiRvAuZy9uzhCOTkho662Ga9BJ5V7+ZQB/TEozvdJ1yQBDIElRNZns1j38Q3q55uCZFzNg7lAdGYIeE0F7rBnO9UOLt2Zh3Fo3c3DNZOIe+6SCsStiKJV9y6A7Mzaah9Ni9WhJ96REYkzaLb4Bh8c=;7:PDyq71kFy9E1TwrCvqnhBVwlBDA+bs1XVDJCojOfLGzM4QhhWfVXYkQnIlUGhcbrQ+ZdQEVUNySZTdYLTLUhCIVjU1hR5mmxukD13g9bMN+7BZqy4qbK7GdGY+3D6VKDqe1FL5DKQe83bkdgKJNZ0eT6ctk40sufV1MuDj3kkKSJrDZ2bQHX1NLRj0weJek5pY6QAgwNLpaR1/eNiaauHvBiz2/D99davNQMWIdVi7U+0ulQQTV0mCjlrhqdSNKv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:WZ15l35db+KsRBdijXP1G4A2900P6PjVuxwNfJUML2h8kAECIVoDQ0kZzqyqYcosgZHA+oy52smjOk2h+iZshoszIVIjl2bIBNsNGTeSAhBhTSLPbbBmfoJyJ0ti65zzhXNsOtJCNq+FILiWxL6vfwjC6HzE+5cKSd6mknLxiC7HN0rk3Hevmunj4aMjSLYV5quC/wnVh0aPZ7dkH4K5hZVx3swI/wUAlQsFpIbjgRUWmVyMYFpUYcmkJ0489BoY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 07:16:41.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a2b532-01df-45c9-f57b-08d61491dd1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2018 5:53 AM, Sasha Levin wrote:
> On Mon, Sep 03, 2018 at 12:16:26PM +0100, Mark Brown wrote:
>> On Sun, Sep 02, 2018 at 01:03:55PM +0000, Sasha Levin wrote:
>>> From: Akshu Agrawal <akshu.agrawal@amd.com>
>>>
>>> [ Upstream commit 9fb4c2bf130b922c77c16a8368732699799c40de ]
>>>
>>> Take into account the base delay set in pointer callback.
>>>
>>> There are cases where a pointer function populates
>>> runtime->delay, such as:
>>> ./sound/pci/hda/hda_controller.c
>>> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>
>> I'm worried that if anyone notices this at all they will have already
>> compensated for the delays in userspace and therefore this will cause
>> them to see problems as they get double compenstation for delays.
> 
> But what happens when they update to a newer Stable? They're going to
> hit that issue anyways.
> 

Drivers which had exposed this delay in pointer function but have
compensated for the issue in userspace are likely see the problem of
double delay when the update happens.
I Don't know what is the best way to communicate that issue is fixed in
kernel and usersapce compensation isn't required.

But more likely I think the delay was just getting left out and there
wouldn't have been a compensation in userspace.

Thanks,
Akshu
