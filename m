Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeB0JdS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:33:18 -0500
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:47662
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752388AbeB0JdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:33:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
 <a2016717-82b1-2802-877b-f947f349f792@caviumnetworks.com>
 <20180227090507.bke37b7loz3vlh5e@katana>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <b09069f2-3163-4777-639d-02ba135ffa72@caviumnetworks.com>
Date: Tue, 27 Feb 2018 15:02:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180227090507.bke37b7loz3vlh5e@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (10.174.150.142)
 To CY1PR07MB2330.namprd07.prod.outlook.com (10.166.194.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 348c056d-12e3-4fb8-14c6-08d57dc51dd1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR07MB2330;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;3:vYOcxjezeBOQ2wNXQAe3mXb8lJVtJG9BKz5w/l/tTu2z4k0RJaxUCicCtaIdZhb9pCGLGhlOD6TG8hCNsvyN9C+NY0zd29aaz33BruZ6OkQFAUPaXlGp8CpcZOImdZ7aW9YWXTFaQszok0b8LuEVxNHVTUChDJSjZR1p5V5rEAJWT5YcqFdmC8ISXtDY3563wnNMWtL18hLKKHzTkjOqKoYLyYFNPtq4BV2Xl5Ph6d6i5zOgMD05vgJ3baC4mrAb;25:mUpQfRdqatLXDoaudAlkTGpKgPn4GMjjWT8UN8vbJ+LwlthvW7udEsXUoHeCGdMOwb5KHjTU7hLf/1pFEfmcyHHQaiD3sCpvW3dNsmyswX/yeb2TQ6ERCZTzlKxmb15zNS26VNZQZVpB00eHeaSIaWuUtbE8d41ckU+seZijIiaX3Ci4xqnusP5IwVFtWYlgVhdRZmKQgQH4QO+hS+t8bTmoFoQ7hZd+HND5YZeTrmApmr4+PMPhbdqBF1m0aWCZdk79sHqJxFtX6PMPANsoYZkyDJhwPiP/52yoOHj1sOq0sk2Q5SacxK8q199lQP1T7fXue9erpGm0fOsZ9brNdw==;31:QBndfNSEFJKIQBawEVVIh3QTvNv9C5ylmIZzVF5wqOMMYDVf3NDtUEfjKZ6rMonsINDzD6wyr4JpbokZBmWraFXLJHamJc8Jre2DmIu8HVvhcQLzB6fMeKJNgtfHpoFRCzcVzgMARsnz4w/KQw743bPkKci/GHSg8bQZKTmyQj+IcutKU1p/FO1uX7uZR/Io7ECaB76jfbDsgWgXkGjckYVefEEfqpQ9CTUN4g4/9dI=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2330:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;20:cXRMgBinmCW2IbRILfmdIGAZGxn5C461OK9qHJQjDLo8f1xHUhnDdf8ezldsCtBEixWRx1ugLB9NazaGgCoAmrXqBWPbIWW13NflzFIXaa0kiPQmROdMGEhd5kASahyDfTy+eZTtBTcdG0jPKaEFdTvP39ltlwxgGbGivCyYda80l61ERIMlqSxB6GDnItK9SBvz4vIykxiTv0HrcEgSNf/E2FEO+nj2xVilxTdw3CSXSh7tEi6fVKCxm9Dp715RwhaLEd3tigoUcdm9t6LwziXGWJvtsN/LTAjNbmd3b1+B3crbpwYBPRXcsWtZou9IRI2ZKHR63nj7NhIIBhDNmGT36e85JMO+Y8PXCxCtf2BI/OSg0pi8GntoGDjSyoEwvCR2WJ19K6DbjjVsuF9ekiuGemvKJZL64XY85JLhnVwRDJdBixZI5wdaz5OHCCat2mOQIY/FHY5FIBgPyeYT2ru9vhLf/friODl0Xukv9bISxqnAsyYbP/srCwaZMtULucyr768AI8Q0FruiGjeyDF02yTkNpb+Hagvo1JtZo4aJg5kPnzpznRql5UuxgQuuiZvjW1fJYdVchMLYMIvcy6zr2vUvdsqR3BxxIcqOCuE=;4:1Cohh1jE0zI9iE+EdQBETEtPhbsmP7O+EvBsDyYO1XsicPIzM4ps5xaQrEmh+vvc/gMZ2Nf8D+5LE7FLr/1Ek1wZQTKvyC+ypeiOsRrGDHn9b5IliqVDxg1Oe5JDniQNUty1rAydb+S1GqM30m/bS1PXe2iTwB8/DW31G2V18O+04CAbwXd/8n0T4fMkIQh3B0wyI2H7dWOekTIDa2JDF8OFw+IcPgiIvzSR+VIOttzsK6ufWx1IazYJKvJoCTCmN6A1q9xBQKNq0ON6/8smoA==
X-Microsoft-Antispam-PRVS: <CY1PR07MB233030E4243D0D39FDC9F0BEF9C00@CY1PR07MB2330.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231220)(944501161)(52105095)(10201501046)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR07MB2330;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2330;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39850400004)(396003)(39380400002)(199004)(189003)(5660300001)(478600001)(4326008)(229853002)(97736004)(65826007)(65806001)(23746002)(8676002)(81156014)(72206003)(31696002)(66066001)(105586002)(68736007)(2906002)(81166006)(47776003)(64126003)(65956001)(36756003)(6916009)(50466002)(53936002)(42882006)(76176011)(2950100002)(7736002)(53546011)(25786009)(67846002)(77096007)(6666003)(6486002)(386003)(16526019)(31686004)(305945005)(6116002)(52116002)(26005)(186003)(8936002)(93886005)(3846002)(6246003)(58126008)(106356001)(90366009)(316002)(5009440100003)(16576012)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2330;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2330;23:wso3gYLmbpJqFFb+hUzj8DbNfrZ9XbWt7y85E?=
 =?Windows-1252?Q?1aPRzvuWzFIXXERpgPqb+PVL8grGJhrliTebyLX1/UUruPjwvDNj68ki?=
 =?Windows-1252?Q?9rn0M2ec5E1qsV9064XCY0VNrWbzRoZbVWjG0umZypCfaQbiiUIZ1/co?=
 =?Windows-1252?Q?QZqTq9a2DaXhXNymXtJ96xVeGIBO0ubwPp6xRVWn0RsdiEYDHhVCJLUt?=
 =?Windows-1252?Q?+cBVUoZOTafDpvmUHVrpw1U7xdorqitXOQEwx/v6E8nDJhHwMR6bicj4?=
 =?Windows-1252?Q?sSTafdsN3cvPDx+QMk+94ES2i/ZL2dHwZna8rU64FBI4OCyoKezMrUdU?=
 =?Windows-1252?Q?sdmByvNBkah+b9QiGWbuXQ/si2kk6rYla3pu/YK+Bu8k4NYQLaUQxov2?=
 =?Windows-1252?Q?744ehIHZSyaS5HuuKt1Ipa9yo0VZn9+xl53CPXYQxyKLb5Ub8ThURqiN?=
 =?Windows-1252?Q?asP5G3oVhbvqTrt76+CgjF9uXZ3sh2WXvbkMw2xllAw/k8NdQGvv7Yvh?=
 =?Windows-1252?Q?vLjmZD4B7SnjZ/VavkLoJ30Z1fDllpLYEHPns1sC/A+NNNd3CNzjmcoP?=
 =?Windows-1252?Q?5ucXKala67DvVu5ZqDngK3W/MKFda2TpO008h8dy8I4kfwwtJge8zO89?=
 =?Windows-1252?Q?fCGp3xyICAXijqINnSwCzkNjmeWFkSOIzOfzhZY2y0gqf+kf8TBnD50M?=
 =?Windows-1252?Q?czTvm8DycQ8eE9YVDK1E9bqxdc+EzLrVIG3jx+doYoQbsT3nhkjAPAIX?=
 =?Windows-1252?Q?bQRz3CwRYrIf/XNWHS4ps1uW98ckQxodlnkD2r1L+9+Osiv4YzfhcIF6?=
 =?Windows-1252?Q?U3TbjYVrZLCHIHotiXs8sv0n1r1C09t34WNsXsq5FaTb38yhu36vW9FY?=
 =?Windows-1252?Q?Hd+UUonO2wegnypa9przMmRcC73+boNabe99ZrXFuSW2UUs7/vVYIgj3?=
 =?Windows-1252?Q?hFG+wa+XElbiA+4GDhVf+O8SDMJgqLhhE80gyRnOEfJVerdYt3zYzxAv?=
 =?Windows-1252?Q?zGJd7O9IjHyqLx4G0Wv0cm8Aj6Sy29h5WumdAW6lxK2EZoh4rVw2hOkF?=
 =?Windows-1252?Q?cgRJnW9uOHlJZvldh9w012cdV4Yxe10N+CCUJvVWZ2ifcj864/D0je/6?=
 =?Windows-1252?Q?B+FDX+sI1P6b5hRMNTvu4ezooPFb7rcVMVDN71EvMIEx1FsAgMzggzlH?=
 =?Windows-1252?Q?HitNC/qtNRf1GCQgSKkZosF5K1AChNaev0c7FNrf7/7xTwL+6us98ukM?=
 =?Windows-1252?Q?SnGDmRHmM38MlONStb+OoxJktVb4wVpcYP1nMc7TETUsMtgLSSYHGYEG?=
 =?Windows-1252?Q?3PR3qKOD0FQu3xBDsqrNYOPrxqqsu70V8HI8a1Ws4JATy8UZ2AfMDC7e?=
 =?Windows-1252?Q?/r8VmS+ibEw0AEh89HbFbDiWh6Eli6/n3QTX3cIR6MsrU3rd3YxiSUz7?=
 =?Windows-1252?Q?d8Bsk1wHBXqaxy/PY6m1DOxtRa/U7u9rvwpXBgjxXJylMTNwi/DvtPOl?=
 =?Windows-1252?Q?lRllr+zhgFgZaNGZW1R74y+P2QxocEQMsLYpTWpIFhYUVFkRQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;6:yYH4AiW2H/B9hO2Krue1Q16WnmBxw439Vt6MkrNXF1zxweIIZDSwAXycZxHxFp6Eu9mQ3dOp/LoIodDnaSBzh+sIxvItTX1VOQL9P0UnZxTfYJXAY3h4RY1NT1xagAD8wstTK29aEjKId4t2FVkFdrMsY4xL/AnS7xnUQlLj+/TvKnI21X+hhCRenxp2TaJjXiJHPlO6hFaubO9GGP2FhE9h34x7Sl+AwIpaaON7mS0Bf0KpHIWLoYX3+VVn+cUyiKb4yTc9zp3mHVr3C6EboyftOTUmjYT4ybmfJumRWVBK3dg4qjS/DJhdrwqUohUPOHny8awrzuAaDsrJpG3OmnIF0Y/03uhW5YcL3O5RIyo=;5:r+obK1hCkXeDUNjEB/lUhUifPIH/AtBjE2WppZDbPl1wWwMf/h7X2Qry2Rxk1TEQwm3Z0aQHO77fiec229rN7BrtCuQjwXLI50debA1bfxhnpAGyc6gFCZX34Cn3S1KYIOT5XCkkb+Xi4O0KI7NOoHNwS3krdUeNz4WsOIUgKqw=;24:kYE78gSXmt2fmKCqjLhynX+EKaXh7VAguJ7saI2VD8gHkpWi1ob0i3ObI55KoOAspECLDoxGfUxngTQjJ26XzDzJ+v6UsKVtdFfH7Wb0mJU=;7:CsytfKfX3+VueGunbemlzOvfCT8K3L9MvLQ1i2XSL03azvGbOjZoWxNDq2jIvv9II35X90QtDdwoRihCmMEP8RfE1sPG5q+j7c0W6oav2Xji3c51B37zTz9mSx8MLaUs/yCWJM+kJYfS+GEKXfr/xbe81CJoE0owP1a25yZP4S5NpoBVuDecnarzgKCuzJlbK4oXpZUtFwFqDlzYHaD0jkQTMCGTkpjp6STaqtrb9Dy3jCoe4vyHEsjSSSRrFNj7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 09:33:08.6157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348c056d-12e3-4fb8-14c6-08d57dc51dd1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 02/27/2018 02:35 PM, Wolfram Sang wrote:
> 
>> Since you raised concern on the patch I thought of reworking this patch.
>> But I can see that this patch is already applied for i2c/for-next.
>> Kindly let me know whether I should be sending follow-up patches on top
>> of i2c/for-next ?
> 
> Oops, that was a mistake on my side. I'll revert that patch. Please
> think of the patch as not-applied-yet.
Okay Noted!!
> 
> Thanks!
> 

Regards,
-George
